//
//  UserListView.swift
//  InstagramClone
//
//  Created by Elvis on 01/09/2023.
//

import SwiftUI

struct UserListView: View {
    @State private var searchUser = ""
    @State var users: [User] = []
    let title: String
    let usersId: [String]?
    
    var body: some View {
        NavigationStack {
            if users.count != 0 {
                List {
                    ForEach(searchResults, id: \.self) { user in
                        UserInfoRow(user: user, followState: checkIsFollowing(targetId: user.id))
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    Task {
                        await getUsersData()
                    }
                }
                .searchable(text: $searchUser, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search username")
            } else {
                Text("No Users")
            }
        }
        .navigationTitle(title)
        .task {
            await getUsersData()
        }
    }
}

extension UserListView {
    var searchResults: [User] {
        if searchUser.isEmpty {
            return users
        } else {
            return users.filter { $0.username.contains(searchUser) }
            
        }
    }
    
    func getUsersData() async {
        do {
            try await AuthService.shared.fetchCurrentUserData()
            guard let usersId = usersId else {
                print("DEBUG - UserListView usersId is empty")
                return
            }
            var bufferUsers: [User] = []
            for id in usersId {
                bufferUsers.append(try await AuthService.shared.fetchUserData(userId: id))
            }
            users = bufferUsers
        } catch {
            print("DEBUG - UserListView \(error.localizedDescription)")
        }
    }
    
    func checkIsFollowing(targetId: String) -> FollowState {
        guard let currentUser = AuthService.shared.currentUser else {
            print("DEBUG - No current user")
            return .cannotFollow
        }
        if currentUser.id == targetId {
            return .cannotFollow
        }
        if currentUser.following.contains(targetId) {
            return .following
        }
        return .notFollowing
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(users: User.MOCK, title: "User List Test", usersId: [String](repeating: UUID().uuidString, count: 10))
    }
}
