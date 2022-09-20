//
//  EmtpyListViewModifier.swift
//  QRPeeps
//
//  Created by William Dupont on 20/09/2022.
//

import SwiftUI

struct EmtpyListView: ViewModifier {
    let condition: Bool
    
    func body(content: Content) -> some View {
        if condition {
            EmptyStateView()
        } else {
            content
        }
    }
}

extension View {
    func emptyListPlaceholder(condition: Bool) -> some View {
        modifier(EmtpyListView(condition: condition))
    }
}
