//
//  DetailedPeepView.swift
//  QRPeeps
//
//  Created by William Dupont on 22/09/2022.
//

import SwiftUI

struct DetailedPeepView: View {
    @EnvironmentObject var peeps: Peeps
    @State private var description: String = ""
    
    let peep: Peep
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            PeepHeader(peep: peep)
            VStack(alignment: .leading, spacing: 12) {
                Divider()
                Text("Notes about this peep:")
                    .font(.headline)
                    .fontWeight(.bold)
                
                PeepNotes(peep: peep, description: $description)
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
