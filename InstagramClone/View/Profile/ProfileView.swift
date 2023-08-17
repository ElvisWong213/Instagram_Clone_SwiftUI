//
//  ProfileView.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI

struct ProfileView: View {
    @State var selection = 1
    @State var showSheet = false
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    ProfilePicture(imageLocation: ImageSource.local(name: "Profile"), size: 100)
                    Spacer()
                    HStack(spacing: 20) {
                        VStack {
                            Text("2")
                            Text("Post")
                        }
                        VStack {
                            Text("2")
                            Text("Followers")
                        }
                        VStack {
                            Text("2")
                            Text("Following")
                        }
                    }
                }
                Text(authService.currentUser?.username ?? "")
                HStack {
                    Button {
                        
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
                    PostGrid()
                        .tag(1)
                    PostGrid()
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
        .sheet(isPresented: $showSheet) {
            NewPostView(showSheet: $showSheet)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthService())
    }
}
