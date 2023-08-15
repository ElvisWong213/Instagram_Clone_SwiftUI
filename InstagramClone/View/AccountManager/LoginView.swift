//
//  LoginView.swift
//  InstagramClone
//
//  Created by Elvis on 11/08/2023.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @Binding var isLogin: Bool
    
    @State var errorMessage: Error? = nil
    @State var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Group {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Forgotten password?")
                            .font(.footnote)
                    }
                }
                Button {
                    login()
                } label: {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                .cornerRadius(10)
                .alert(errorMessage?.localizedDescription ?? "", isPresented: $showAlert, actions: {
                    Button {
                        errorMessage = nil
                        showAlert = false
                    } label: {
                        Text("Ok")
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
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                errorMessage = error
                showAlert = true
            } else {
                isLogin = true
                print("Login succes")
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLogin: .constant(false))
    }
}
