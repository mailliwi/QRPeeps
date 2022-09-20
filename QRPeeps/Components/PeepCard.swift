//
//  PeepCard.swift
//  QRPeeps
//
//  Created by William Dupont on 18/09/2022.
//

import SwiftUI

struct PeepCard: View {
    let peep: Peep
    
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .padding(6)
                .foregroundColor(.gray)
                .background(.white)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(peep.name)
                    .font(.headline)
                Text(peep.emailAddress)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            Image(systemName: "circle")
                .foregroundColor(peep.isContacted ? .green : .red)
        }
        .padding(.vertical, 6)
    }
}
