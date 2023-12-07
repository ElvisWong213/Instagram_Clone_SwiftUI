//
//  CustomTabView.swift
//  InstagramClone
//
//  Created by Elvis on 06/12/2023.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedItem: TabBarItem
    
    var body: some View {
        HStack {
            ForEach(TabBarItem.allCases, id: \.self) { item in
                Spacer()
                Button {
                    selectedItem = item
                } label: {
                    Image(systemName: item == selectedItem ? item.selectedIcon : item.icon)
                        .foregroundColor(.primary)
                        .bold(item == selectedItem && item == .Search)
                }
                Spacer()
            }
        }
        .font(.title2)
        .padding(.vertical)
        .fixedSize(horizontal: false, vertical: true)
    }
}

#if DEBUG
private struct CustomTabView_Previews: View {
    @State private var selectedItem: TabBarItem = .Home
    
    var body: some View {
        CustomTabView(selectedItem: $selectedItem)
    }
}
#endif

#Preview {
    CustomTabView_Previews()
}
