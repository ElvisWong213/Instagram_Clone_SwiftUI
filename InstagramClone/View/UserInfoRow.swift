//
//  UserInfoRow.swift
//  InstagramClone
//
//  Created by Elvis on 01/09/2023.
//

import SwiftUI

struct UserInfoRow: View {
    var user: User
    @State var followState: FollowState
    
    var body: some View {
        ZStack {
            HStack {
                ProfilePicture(imageLocation: .remote(url: URL(string: user.image ?? "")), size: 50)
                VStack(alignment: .leading) {
                    Text(user.username)
                    Text(user.fullname ?? "")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                Spacer()
                if followState != .cannotFollow {
                    Button {
                        Task {
                            if followState == .notFollowing {
                                followState = await FollowService().followingUser(targetId: user.id)
                            } else if followState == .following {
                                followState = await FollowService().unfollowingUser(targetId: user.id)
                            }
                        }
                    } label: {
                        Text(followState.tag)
                            .padding(.horizontal)
                            .font(.callout)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(followState == .notFollowing ? .blue : .gray)
                }
            }
            NavigationLink(destination: ProfileView(userId: user.id)) {
                EmptyView()
            }
            .opacity(0)
        }
    }
}

struct UserInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoRow(user: User.MOCK[0], followState: .notFollowing)
    }
}
