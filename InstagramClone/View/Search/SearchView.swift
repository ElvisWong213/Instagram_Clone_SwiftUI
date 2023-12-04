//
//  SearchView.swift
//  InstagramClone
//
//  Created by Elvis on 25/11/2023.
//

import SwiftUI

struct SearchView: View {
    @State var posts: [Post] = Post.MOCK
    @State var searchText: String = ""
    @State var searchFocused: Bool = false
    
    @State var userList: [User] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchTextField(searchText: $searchText, searchFocused: $searchFocused)
                ZStack {
                    PostGrid(posts: $posts)
                    List {
                        ForEach(userList) { user in
                            UserInfoRow(user: user, followState: FollowService.checkIsFollowing(targetId: user.id))
                                .listRowInsets(EdgeInsets())
                                .padding(.vertical)
                        }
                    }
                    .listStyle(.inset)
                    .opacity(searchFocused ? 1 : 0)
                }
            }
            .padding()
        }
        .onChange(of: searchFocused) {
            if searchFocused == true {
                Task {
                    userList = await SearchUserService.searching(username: searchText)
                }
            }
        }
        .onChange(of: searchText) { oldValue, newValue in
            if oldValue != newValue {
                Task {
                    userList = await SearchUserService.searching(username: newValue)
                }
            }
        }
        .task {
            posts = await PostService.fetchSuggestPosts()
        }
    }
}

#Preview {
    SearchView()
}
