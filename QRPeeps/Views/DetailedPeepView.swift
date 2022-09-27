//
//  DetailedPeepView.swift
//  QRPeeps
//
//  Created by William Dupont on 22/09/2022.
//

import SwiftUI

struct DetailedPeepView: View {
    @State private var description: String = ""
    @FocusState private var isFocused: Bool
    
    private var defaultDescriptionText: String {
        if isFocused || !description.isEmpty {
            return ""
        } else {
            return "Tap to start editing..."
        }
    }
    
    let peep: Peep
    let borderColor = Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 1)
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            PeepHeader(peep: peep)
            VStack(alignment: .leading, spacing: 12) {
                Divider()
                Text("Notes about this peep:")
                    .font(.headline)
                    .fontWeight(.bold)
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $description)
                        .frame(height: 250)
                        .lineLimit(5)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(borderColor, lineWidth: 1))
                        .focused($isFocused)
                    
                    Text(defaultDescriptionText)
                        .italic()
                        .padding()
                        .foregroundColor(.secondary)
                        .allowsHitTesting(false)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
        }
        .frame(maxWidth: .infinity)
        .navigationTitle(peep.name)
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            hideKeyboard()
        }
    }
}
