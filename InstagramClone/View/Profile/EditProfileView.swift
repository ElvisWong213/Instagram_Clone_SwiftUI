//
//  EditProfileView.swift
//  InstagramClone
//
//  Created by Elvis on 17/08/2023.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var authService: AuthService
    @Environment(\.dismiss) var dismiss
    
    @State var image: ImageSource?
    @State var name: String = ""
    @State var username: String = ""
    @State var pronouns: String = ""
    @State var link: String = ""
    @State var gender: Gender = .None
    
    @State var errorMessage: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    
                } label: {
                    ProfilePicture(imageLocation: image, size: 100)
                }
                Form {
                    TextField("Name", text: $name)
                    TextField("Username", text: $username)
                    TextField("Pronouns", text: $pronouns)
                    TextField("Link", text: $link)
                    Picker(selection: $gender, label: Text("Gender")) {
                        ForEach(Gender.allCases) { option in
                            Text(String(describing: option))
                        }
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        Task {
                            await updateUserInfo()
                        }
                    }
                }
            }
            .alert(errorMessage, isPresented: $showAlert) {
                
            }
        }
        .onAppear() {
            initialUserInfo()
        }
    }
}

extension EditProfileView {
    func updateUserInfo() async {
        guard var user = authService.currentUser else {
            errorMessage = UserError.UnableGetUserData.localizedDescription
            showAlert = true
            return
        }
        user.name = name
        user.username = username
        user.pronouns = pronouns
        user.link = link
        user.gender = gender
        do {
            try await authService.updateUserData(user: user)
        } catch {
            print("Update user info fail: \(error.localizedDescription)_")
            errorMessage = error.localizedDescription
            showAlert = true
            return
        }
        dismiss()
    }
    
    func initialUserInfo() {
        guard let user = authService.currentUser else {
            errorMessage = UserError.UnableGetUserData.localizedDescription
            showAlert = true
            return
        }
        let imageUrl = URL(string: user.image!)
        self.image = ImageSource.remote(url: imageUrl)
        self.name = user.name ?? ""
        self.username = user.username
        self.pronouns = user.pronouns ?? ""
        self.link = user.link ?? ""
        self.gender = user.gender ?? .None
    }
}


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
