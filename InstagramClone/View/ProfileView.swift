//
//  ProfileView.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State var selection = 1
    
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
                Text("User Name")
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
                    do {
                        try Auth.auth().signOut()
                    } catch {
                        print(error)
                    }
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
            .navigationTitle("User Name")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        
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
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
