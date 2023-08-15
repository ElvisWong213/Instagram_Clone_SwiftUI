//
//  PageView.swift
//  InstagramClone
//
//  Created by Elvis on 14/08/2023.
//

import SwiftUI

struct PageView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    var isLock: Bool
    let content: Content
    
    @GestureState private var translation: CGFloat = 0
    @GestureState private var dummy: CGFloat = 0
    
    init(pageCount: Int, currentIndex: Binding<Int>, isLock: Bool, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.isLock = isLock
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { gr in
            HStack(spacing: 0) {
                self.content.frame(width: gr.size.width)
            }
            .frame(width: gr.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * gr.size.width)
            .offset(x: self.translation)
            .animation(.interactiveSpring(), value: currentIndex)
            .animation(.interactiveSpring(), value: translation)
            .gesture(
                DragGesture()
                    .updating(!isLock ? self.$translation : self.$dummy) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        if !isLock {
                            let offset = value.translation.width / gr.size.width
                            let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                            self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                        }
                }
            )
        }
    }
}

struct PageView_Previews: PreviewProvider {
    @State static var currentPage = 0
    
    static var previews: some View {
        PageView(pageCount: 2, currentIndex: .constant(0), isLock: false) {
            Color.red
            Color.blue
        }
    }
}
