//
//  HiddenModifier.swift
//  ReadingLogs
//
//  Created by 鈴木航太 on 2024/03/26.
//

import SwiftUI

struct HiddenModifier: ViewModifier {
    var isEnabled = false
    func body(content: Content) -> some View {
        if isEnabled {
            content
                .hidden()
        } else {
            content
        }
        
    }
}

extension View {
    func hidden(isEnabled: Bool) -> some View {
        modifier(HiddenModifier(isEnabled: isEnabled))
    }
}
