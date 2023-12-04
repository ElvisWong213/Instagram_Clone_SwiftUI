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
    
    var body: some View {
        TabView(selection: $mainPageVM.HomeViewSelection) {
            HomeView()
                .tabItem { Image(systemName: "house") }
                .tag(1)
            SearchView()
                .tabItem { Image(systemName: "magnifyingglass") }
                .tag(2)
            Text("")
                .tabItem { Image(systemName: "plus.square") }
                .tag(3)
            Text("Tab Content 2")
                .tabItem { Image(systemName: "video") }
                .tag(4)
            ProfileView(userId: vm.authService.currentUser?.id ?? "")
                .tabItem { Image(systemName: "person.crop.circle") }
                .tag(5)
        }
        .onChange(of: mainPageVM.HomeViewSelection) { oldValue, newValue in
            if newValue == 3 {
                vm.showSheet = true
            } else {
                vm.previousSelection = mainPageVM.HomeViewSelection
            }
        }
        .tabViewStyle(.automatic)
        .fullScreenCover(isPresented: $vm.showSheet, onDismiss: {
            mainPageVM.HomeViewSelection = vm.previousSelection
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
