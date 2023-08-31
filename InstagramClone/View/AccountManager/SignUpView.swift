//
//  SignUpView.swift
//  InstagramClone
//
//  Created by Elvis on 12/08/2023.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authService: AuthService
    @StateObject var vm = SignUpVM()
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Create Account")
                .font(.title)
                .bold()
            InputField(title: "Username", input: $vm.username, isPassword: false)
            InputField(title: "Email", input: $vm.email, isPassword: false)
            InputField(title: "Password", input: $vm.password, isPassword: true)
            Button {
                Task {
                    await createAccount()
                }
            } label: {
                Text("Create account")
                    .frame(maxWidth: .infinity)
            }
            .disabled(vm.allFieldEmpty())
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
        }
        .alert(vm.errorMessage, isPresented: $vm.showAlert, actions: {
            Button {
                vm.showAlert = false
            } label: {
                Text("OK")
            }
        })
        .padding(.horizontal, 40)
    }
}

extension SignUpView {
    func createAccount() async {
        do {
            try await authService.createUser(email: vm.email, password: vm.password, username: vm.username)
        } catch {
            vm.showAlert = true
            vm.errorMessage = error.localizedDescription
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthService())
    }
}
