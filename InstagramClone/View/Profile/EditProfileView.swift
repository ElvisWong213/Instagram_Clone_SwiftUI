//
//  EditProfileView.swift
//  InstagramClone
//
//  Created by Elvis on 17/08/2023.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    let authService = AuthService.shared
    @Environment(\.dismiss) var dismiss
    
    @State var image: ImageSource?
    @State var name: String = ""
    @State var username: String = ""
    @State var pronouns: String = ""
    @State var link: String = ""
    @State var gender: Gender = .None
    
    @State var errorMessage: String = ""
    @State var showAlert: Bool = false
    
    @State var selectedImage: PhotosPickerItem?
    @State var selectedUIImage: UIImage?
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker(selection: $selectedImage, matching: .images) {
                    ProfilePicture(imageLocation: image, size: 100)
                }
                Form {
                    EditProfileRow(title: "Name", text: $name)
                    EditProfileRow(title: "Username", text: $username)
                    EditProfileRow(title: "Pronouns", text: $pronouns)
                    EditProfileRow(title: "Link", text: $link)
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
                        dismiss()
                    }
                }
            }
            .alert(errorMessage, isPresented: $showAlert) {}
        }
        .onAppear() {
            initialUserInfo()
        }
        .onChange(of: selectedImage) { _ in
            Task {
                await convertSelectedImage()
            }
        }
    }
}

extension EditProfileView {
    func convertSelectedImage() async {
        do {
            if let data = try await selectedImage?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedUIImage = uiImage
                    image = .image(image: Image(uiImage: uiImage))
                }
            }
        } catch {
            print("DEBUG - Unable to convert selected image to uiimage: \(error.localizedDescription)")
        }
    }
    
    func updateUserInfo() async {
        do {
            guard var user = authService.currentUser else {
                throw UserError.UnableGetUserData
            }
            if let uiImage = selectedUIImage {
                user.image = try await authService.uploadUserProfileImage(image: uiImage)
            }
            user.name = name
            user.username = username
            user.pronouns = pronouns
            user.link = link
            user.gender = gender
            try await authService.updateUserData(user: user)
        } catch {
            print("DEBUG - Update user info fail: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
            showAlert = true
            return
        }
    }
    
    func initialUserInfo() {
        guard let user = authService.currentUser else {
            errorMessage = UserError.UnableGetUserData.localizedDescription
            showAlert = true
            return
        }
        self.image = .remote(url: URL(string: user.image ?? ""))
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
