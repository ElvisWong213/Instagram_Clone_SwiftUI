//
//  LoginView.swift
//  InstagramClone
//
//  Created by Elvis on 11/08/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State var errorMessage: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                Spacer()
                InputField(title: "Email", input: $email, isPassword: false)
                InputField(title: "Password", input: $password, isPassword: true)
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Forgotten password?")
                            .font(.footnote)
                    }
                }
                Button {
                    Task {
                        await login()
                    }
                } label: {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                .cornerRadius(10)
                .alert(errorMessage, isPresented: $showAlert, actions: {
                    Button {
                        errorMessage = ""
                        showAlert = false
                    } label: {
                        Text("OK")
                    }
                })
                Spacer()
                NavigationLink("Sign Up") {
                    SignUpView()
                }
            }
            .padding(.horizontal, 40)
        }
    }
    
    func login() async {
        do {
            try await AuthService.shared.signIn(email: email,password: password)
        } catch {
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthService())
    }
}
