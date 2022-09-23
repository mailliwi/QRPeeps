//
//  PeepCard.swift
//  QRPeeps
//
//  Created by William Dupont on 18/09/2022.
//

import SwiftUI

struct PeepCard: View {
    let peep: Peep
    let filter: PeepFilterType
    let isContacted: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(peep.name)
                Text(peep.emailAddress)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .textCase(.lowercase)
            }
            
            if filter == .none {
                Spacer()
                Image(systemName: peep.isContacted ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(peep.isContacted ? .green : .red)
            }
        }
        .padding(.vertical, 6)
    }
}
