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
    @FocusState var isFocused: Bool
    
    @State var userList: [User] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .onTapGesture {
                            withAnimation {
                                searchFocused = true
                            }
                        }
                        .focused($isFocused)
                    if searchFocused {
                        Button {
                            withAnimation {
                                searchFocused.toggle()
                            }
                            searchText = ""
                            isFocused.toggle()
                        } label: {
                            Text("Cancel")
                        }
                        .transition(.move(edge: .trailing))
                    }
                }
                .animation(.easeInOut, value: searchFocused)
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
        .onChange(of: searchText) { oldValue, newValue in
            if oldValue != newValue {
                Task {
                    userList = await SearchUserService.searching(username: newValue)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
