//
//  KeyBordHealper.swift
//  SwiftUI R&D
//
//  Created by Rezaul Islam on 4/10/24.
//

import Foundation
import SwiftUI

// Custom ViewModifier for reusable behavior
struct KeyboardAwareModifier: ViewModifier {
    
    @Binding var text: String
    let id: String
    let sp: ScrollViewProxy
    
    func body(content: Content) -> some View {
        content
            .id(id)
            .onChange(of: text) { _ in
                withAnimation(.easeOut(duration: 0.3)) {
                    sp.scrollTo(id, anchor: .bottom)
                }
            }
    }
}

// A convenience method to apply the modifier
extension View {
    func keyboardAwarePadding(  text: Binding<String>, id: String, sp: ScrollViewProxy) -> some View {
        self.modifier(KeyboardAwareModifier(  text: text, id: id, sp: sp))
    }
}
