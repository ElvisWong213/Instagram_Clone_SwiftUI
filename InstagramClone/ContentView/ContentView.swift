//
//  ContentView.swift
//  InstagramClone
//
//  Created by Elvis on 11/08/2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject var vm = ContentVM()
    
    var body: some View {
        Group {
            if $vm.userSession != nil {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
