//
//  ProfileButtons.swift
//  InstagramClone
//
//  Created by Elvis on 04/09/2023.
//

import SwiftUI

struct ProfileButtons: View {
    let userId: String
    @State var followState: FollowState
    
    var body: some View {
        HStack {
            if userId == AuthService.shared.currentUser?.id {
                NavigationLink {
                    EditProfileView()
                } label: {
                    Text("Edit Profile")
                        .frame(maxWidth: .infinity)
                }
                Button {
                    
                } label: {
                    Text("Share Profile")
                        .frame(maxWidth: .infinity)
                }
            } else {
                Button {
                    Task {
                        if followState == .notFollowing {
                            followState = await FollowService.followingUser(targetId: userId)
                        } else if followState == .following {
                            followState = await FollowService.unfollowingUser(targetId: userId)
                        }
                    }
                    
                } label: {
                    Text(followState.tag)
                        .frame(maxWidth: .infinity)
                }
                .tint(followState == .notFollowing ? .blue : .gray)
                Button {
                    
                } label: {
                    Text("Message")
                        .frame(maxWidth: .infinity)
                }
            }
            Button {
                
            } label: {
                Image(systemName: "person.badge.plus")
            }
        }
        
        .buttonStyle(.borderedProminent)
        .frame(maxWidth: .infinity)
    }
}

struct ProfileEditButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButtons(userId: "", followState: .notFollowing)
    }
}
