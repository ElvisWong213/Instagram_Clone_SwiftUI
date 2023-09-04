//
//  HomeView.swift
//  InstagramClone
//
//  Created by Elvis on 04/09/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var mainPageVM: MainPageVM
    @StateObject var vm = HomeVM()
    
    var body: some View {
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
                        mainPageVM.MainTabSelection = 2
                    } label: {
                        Image(systemName: "message")
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(MainPageVM())
    }
}
