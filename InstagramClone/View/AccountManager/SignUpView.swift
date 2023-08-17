//
//  SignUpView.swift
//  InstagramClone
//
//  Created by Elvis on 12/08/2023.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authService: AuthService
    
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var errorMessage: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Create Account")
                .font(.title)
                .bold()
            InputField(title: "Username", input: $username, isPassword: false)
            InputField(title: "Email", input: $email, isPassword: false)
            InputField(title: "Password", input: $password, isPassword: true)
            Button {
                Task {
                    await createAccount()
                }
            } label: {
                Text("Create account")
                    .frame(maxWidth: .infinity)
            }
            .disabled(username.isEmpty || email.isEmpty || password.isEmpty)
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
        }
        .alert(errorMessage, isPresented: $showAlert, actions: {
            Button {
                showAlert = false
            } label: {
                Text("OK")
            }
        })
        .padding(.horizontal, 40)
    }
    
    func createAccount() async {
        do {
            try await authService.createUser(email: email, password: password, username: username)
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthService())
    }
}
