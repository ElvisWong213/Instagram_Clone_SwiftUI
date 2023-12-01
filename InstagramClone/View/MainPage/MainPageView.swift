//
//  MainPageView.swift
//  InstagramClone
//
//  Created by Elvis on 01/09/2023.
//

import SwiftUI

struct MainPageView: View {
    @StateObject var vm = MainPageVM()
    
    var body: some View {
        PageView(pageCount: 3, currentIndex: $vm.MainTabSelection, isLock: vm.isLock) {
            Text("Camera")
            MainTabView()
                .environmentObject(vm)
            MessageView()
        }
        .onChange(of: vm.HomeViewSelection) { oldValue, newValue in
            if newValue == 1 {
                vm.isLock = false
            } else {
                vm.isLock = true
            }
        }
        .animation(.default, value: vm.MainTabSelection)
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
