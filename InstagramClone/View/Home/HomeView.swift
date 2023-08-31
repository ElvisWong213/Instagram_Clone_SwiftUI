//
//  HomeView.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeVM()
    @Binding var viewSelection: Int
    
    var body: some View {
        TabView(selection: $viewSelection) {
            NavigationStack {
                ScrollView {
                    if vm.posts.isEmpty {
                        Text("No posts yet")
                    } else {
                        LazyVStack {
                            ForEach($vm.posts) { post in
                                PostView(postData: post)
                            }
                        }
                    }
                }
                .task {
                    await vm.fetchPost()
                }
                .refreshable {
                    await vm.fetchPost()
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                        }
                    }
                    ToolbarItem {
                        Button {
//                            selection = 2
                        } label: {
                            Image(systemName: "message")
                        }
                    }
                }
            }
                .tabItem { Image(systemName: "house") }
                .tag(1)
            Text("Tab Content 2")
                .tabItem { Image(systemName: "magnifyingglass") }
                .tag(2)
            Text("")
                .tabItem { Image(systemName: "plus.square") }
                .tag(3)
            Text("Tab Content 2")
                .tabItem { Image(systemName: "video") }
                .tag(4)
            ProfileView()
                .tabItem { Image(systemName: "person.crop.circle") }
                .tag(5)
        }
        .onChange(of: viewSelection, perform: { newValue in
            if newValue == 3 {
                vm.showSheet = true
            } else {
                vm.previousSelection = viewSelection
            }
        })
        .tabViewStyle(.automatic)
        .sheet(isPresented: $vm.showSheet, onDismiss: {
            viewSelection = vm.previousSelection
        }) {
            NewPostView(showSheet: $vm.showSheet)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewSelection: .constant(1))
    }
}
