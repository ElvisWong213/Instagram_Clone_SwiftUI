//
//  SignUpView.swift
//  InstagramClone
//
//  Created by Elvis on 12/08/2023.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var errorMessage: Error? = nil
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Create Account")
                .font(.title)
                .bold()
            Group {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                SecureField("Comfirm Password", text: $confirmPassword)
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5)
            Button {
                createAccount()
            } label: {
                Text("Create account")
                    .frame(maxWidth: .infinity)
            }
            .disabled(username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
        }
        .alert(errorMessage?.localizedDescription ?? "", isPresented: $showAlert, actions: {
            Button {
                errorMessage = nil
                showAlert = false
            } label: {
                Text("Ok")
            }
        })
        .padding(.horizontal, 40)
    }
    
    func createAccount()  {
        if password != confirmPassword {
            errorMessage = CreateAccountError.PasswordNotMatch
            showAlert = true
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                errorMessage = error
                showAlert = true
            } else {
                print("Create account success")
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

enum CreateAccountError: Error, LocalizedError {
    case PasswordNotMatch
    
    var errorDescription: String? {
        switch self {
        case .PasswordNotMatch:
            return "Password not match"
        }
    }
}
