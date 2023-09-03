//
//  UserListView.swift
//  InstagramClone
//
//  Created by Elvis on 01/09/2023.
//

import SwiftUI

struct UserListView: View {
    @State private var searchUser = ""
    @State var users: [User] = [User]()
    let title: String
    let usersId: [String]?
    
    var body: some View {
        Group {
            if users.count != 0 {
                List {
                    ForEach(searchResults, id: \.self) { user in
                        UserInfoRow(user: user)
                    }
                }
                .listStyle(.plain)
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
    func getUsersData() async {
        do {
            guard let usersId = usersId else {
                print("DEBUG - usersId is empty")
                return
            }
            for id in usersId {
                users.append(try await AuthService.shared.fetchUserData(userId: id))
            }
        } catch {
            print("DEBUG - \(error.localizedDescription)")
        }
    }
    
    var searchResults: [User] {
        if searchUser.isEmpty {
            return users
        } else {
            return users.filter { $0.username.contains(searchUser) }
            
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(users: User.MOCK, title: "User List Test", usersId: [String](repeating: UUID().uuidString, count: 10))
    }
}
