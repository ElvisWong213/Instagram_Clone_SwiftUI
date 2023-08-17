//
//  ContentView.swift
//  InstagramClone
//
//  Created by Elvis on 11/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State var pageSelection = 1
    @State var viewSelection = 1
    @State var isLock = false
        
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        VStack {
            if authService.userSession != nil {
                content
            } else {
                LoginView()
            }
        }
    }
    
    var content: some View {
        PageView(pageCount: 3, currentIndex: $pageSelection, isLock: isLock) {
            Text("Camera")
            HomeView(viewSelection: $viewSelection)
            MessageView()
        }
        .onChange(of: viewSelection, perform: { newValue in
            if newValue == 1 {
                isLock = false
            } else {
                isLock = true
            }
        })
        .animation(.default, value: pageSelection)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthService())
    }
}
