//
//  PeepNotes.swift
//  QRPeeps
//
//  Created by William Dupont on 27/09/2022.
//

import SwiftUI

struct PeepNotes: View {
    let peep: Peep
    
    @Binding var description: String
    @EnvironmentObject var peeps: Peeps
    @FocusState var isFocused: Bool
    
    private var defaultDescription: String {
        if isFocused || !description.isEmpty {
            return ""
        } else {
            return "Tap to start editing..."
        }
    }
    
    private var trimmedDescription: String {
        let trimmedString = String(description.prefix(Constants.kCharacterLimit))
        return trimmedString
    }
    
    func fetchPeepDescription() {
        description = peep.description
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $description)
                .frame(height: 250)
                .lineLimit(5)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(.secondary, lineWidth: 0.2))
                .focused($isFocused)
            
            
            Text(defaultDescription)
                .italic()
                .padding()
                .foregroundColor(.secondary)
                .allowsHitTesting(false)
        }
        .onAppear(perform: fetchPeepDescription)
        .onChange(of: trimmedDescription) { _ in
            peeps.addDescription(for: peep, description: trimmedDescription)
        }
        .characterLimitCounter(for: description.count)
    }
}

