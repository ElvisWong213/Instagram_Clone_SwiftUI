//
//  HomeView.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI

struct HomeView: View {
    @Binding var viewSelection: Int
    @State var previousSelection: Int = 1
    @State var showSheet = false
    
    var body: some View {
        TabView(selection: $viewSelection) {
            NavigationStack {
                ScrollView {
                    VStack {
                        ForEach(0..<10) { _ in
                            PostView()
                        }
                    }
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
                showSheet = true
            } else {
                previousSelection = viewSelection
            }
        })
        .tabViewStyle(.automatic)
        .sheet(isPresented: $showSheet, onDismiss: {
            viewSelection = previousSelection
        }) {
            NewPostView(showSheet: $showSheet)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewSelection: .constant(1))
    }
}
