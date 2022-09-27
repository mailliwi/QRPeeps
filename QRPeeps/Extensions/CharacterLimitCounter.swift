//
//  CharacterLimitCounter.swift
//  QRPeeps
//
//  Created by William Dupont on 27/09/2022.
//

import SwiftUI

struct CharacterLimitCounter: ViewModifier {
    var counter: Int

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text("Character limit: \(counter)/120")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding()
        }
    }
}

extension View {
    func characterLimitCounter(counter: Int) -> some View {
        modifier(CharacterLimitCounter(counter: counter))
    }
}
