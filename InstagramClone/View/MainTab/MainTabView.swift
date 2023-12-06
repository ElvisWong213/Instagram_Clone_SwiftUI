//
//  MainTabView.swift
//  InstagramClone
//
//  Created by Elvis on 13/08/2023.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var mainPageVM: MainPageVM
    @StateObject var vm = MainTabVM()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            TabView(selection: $mainPageVM.TabBarSelection) {
                HomeView()
                    .tag(TabBarItem.Home)
                SearchView()
                    .tag(TabBarItem.Search)
                Text("")
                    .tag(TabBarItem.Add)
                Text("Tab Content 2")
                    .tag(TabBarItem.Reels)
                ProfileView(userId: vm.authService.currentUser?.id ?? "")
                    .tag(TabBarItem.Profile)
            }
            CustomTabView(selectedItem: $mainPageVM.TabBarSelection)
        }
        .onChange(of: mainPageVM.TabBarSelection) { oldValue, newValue in
            if newValue == TabBarItem.Add {
                vm.showSheet = true
            } else {
                vm.previousSelection = mainPageVM.TabBarSelection
            }
        }
        .tabViewStyle(.automatic)
        .fullScreenCover(isPresented: $vm.showSheet, onDismiss: {
            mainPageVM.TabBarSelection = vm.previousSelection
        }) {
            NewPostView(showSheet: $vm.showSheet)
        }
    }
}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(MainPageVM())
    }
}
