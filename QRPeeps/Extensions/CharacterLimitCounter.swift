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
            Text("Character limit: \(counter)/\(Constants.kCharacterLimit)")
                .font(.caption)
                .foregroundColor(counter > Constants.kCharacterLimit ? .red : .secondary)
                .padding()
        }
    }
}

extension View {
    func characterLimitCounter(for counter: Int) -> some View {
        modifier(CharacterLimitCounter(counter: counter))
    }
}
