//
//  PeepCard.swift
//  QRPeeps
//
//  Created by William Dupont on 18/09/2022.
//

import SwiftUI

struct PeepCard: View {
    let peep: Peep
    let isContacted: Bool
    let filter: PeepFilterType
    
    var body: some View {
        HStack {
            if peep.image == nil {
                Image(systemName: "person")
                    .frame(width: 32, height: 32)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .background(.white)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.gray, lineWidth: 1))
            } else {
                Image(uiImage: UIImage(data: peep.image!)!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                
            }
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
