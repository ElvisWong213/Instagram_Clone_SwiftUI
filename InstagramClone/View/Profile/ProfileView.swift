//
//  ProfileView.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var contentVM: ContentVM
    @State var selection = 1
    @State var showSheet = false
    let authService = AuthService.shared
    @State var profilePicUrl: URL!
    @State var posts: [Post] = []
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    ProfilePicture(imageLocation: .remote(url: profilePicUrl), size: 100)
                    Spacer()
                    HStack(spacing: 20) {
                        VStack {
                            Text("\(posts.count)")
                            Text("Post")
                        }
                        NavigationLink {
                            UserListView(title: "Followers", usersId: authService.currentUser?.followers)
                        } label: {
                            VStack {
                                Text("\(contentVM.currentUser?.followers.count ?? 0)")
                                Text("Followers")
                            }
                        }
                        NavigationLink {
                            UserListView(title: "Following", usersId: authService.currentUser?.following)
                        } label: {
                            VStack {
                                Text("\(contentVM.currentUser?.following.count ?? 0)")
                                Text("Following")
                            }
                        }
                    }
                }
                .font(.callout)
                Text(authService.currentUser?.fullname ?? "")
                HStack {
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
                    Button {
                        
                    } label: {
                        Image(systemName: "person.badge.plus")
                    }
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                Button {
                    authService.signOut()
                } label: {
                    Text("Logout")
                }
                .buttonStyle(.bordered)
                Picker(selection: $selection, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                    Image(systemName: "squareshape.split.3x3")
                        .tag(1)
                    Image(systemName: "person.fill.viewfinder")
                        .tag(2)
                }
                .pickerStyle(.segmented)
                TabView(selection: $selection) {
                    PostGrid(posts: $posts)
                        .tag(1)
                    PostGrid(posts: $posts)
                        .tag(2)
                }
                .animation(.default, value: selection)
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .padding(.horizontal)
            .navigationTitle(authService.currentUser?.username ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        showSheet = true
                    } label: {
                        Image(systemName: "plus.app")
                    }
                }
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                }
            }
        }
        .sheet(isPresented: $showSheet, onDismiss: {
            getProfilePicUrl()
        }) {
            NewPostView(showSheet: $showSheet)
        }
        .onAppear() {
            getProfilePicUrl()
        }
        .task {
            posts = await PostService().fetchPosts()
            try? await authService.fetchLoginUserData()
        }
        .refreshable {
            Task {
                posts = await PostService().fetchPosts()
                try? await authService.fetchLoginUserData()
            }
        }
    }
}

extension ProfileView {
    func getProfilePicUrl() {
        guard let url = authService.currentUser?.image else {
            return
        }
        self.profilePicUrl = URL(string: url)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthService())
            .environmentObject(ContentVM())
    }
}
