//
//  MainTabView.swift
//  InstagramClone
//
//  Created by Elvis on 01/09/2023.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var vm = MainTabVM()
    
    var body: some View {
        PageView(pageCount: 3, currentIndex: $vm.MainTabSelection, isLock: vm.isLock) {
            Text("Camera")
            HomeView()
                .environmentObject(vm)
            MessageView()
        }
        .onChange(of: vm.HomeViewSelection, perform: { newValue in
            if newValue == 1 {
                vm.isLock = false
            } else {
                vm.isLock = true
            }
        })
        .animation(.default, value: vm.MainTabSelection)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
