//
//  ProfileView.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var vm = ProfileVM()
    let userId: String
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    ProfilePicture(imageLocation: .remote(url: URL(string: vm.user?.image ?? "")), size: 100)
                    Spacer()
                    HStack(spacing: 20) {
                        VStack {
                            Text("\(vm.posts.count)")
                            Text("Post")
                        }
                        NavigationLink {
                            UserListView(title: "Followers", usersId: vm.user?.followers)
                        } label: {
                            VStack {
                                Text("\(vm.user?.followers.count ?? 0)")
                                Text("Followers")
                            }
                        }
                        NavigationLink {
                            UserListView(title: "Following", usersId: vm.user?.following)
                        } label: {
                            VStack {
                                Text("\(vm.user?.following.count ?? 0)")
                                Text("Following")
                            }
                        }
                    }
                }
                .font(.callout)
                Text(vm.user?.fullname ?? "")
                ProfileButtons(userId: userId, followState: vm.checkIsFollowing(targetId: userId))
                Picker(selection: $vm.selection, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                    Image(systemName: "squareshape.split.3x3")
                        .tag(1)
                    Image(systemName: "person.fill.viewfinder")
                        .tag(2)
                }
                .pickerStyle(.segmented)
                TabView(selection: $vm.selection) {
                    PostGrid(posts: $vm.posts)
                        .tag(1)
                    PostGrid(posts: $vm.posts)
                        .tag(2)
                }
                .animation(.default, value: vm.selection)
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .padding(.horizontal)
            .navigationTitle(vm.user?.username ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        vm.showSheet = true
                    } label: {
                        Image(systemName: "plus.app")
                    }
                }
                ToolbarItem {
                    Menu {
                        Button {
                            vm.authService.signOut()
                        } label: {
                            Text("Logout")
                        }
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $vm.showSheet, onDismiss: {
            Task {
                await vm.fetchData(userId: userId)
            }
        }) {
            NewPostView(showSheet: $vm.showSheet)
        }
        .task {
            await vm.fetchData(userId: userId)
        }
        .refreshable {
            Task {
                await vm.fetchData(userId: userId)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userId: "123")
    }
}
