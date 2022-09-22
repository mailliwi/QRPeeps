//
//  PeepHeader.swift
//  QRPeeps
//
//  Created by William Dupont on 22/09/2022.
//

import SwiftUI

struct PeepHeader: View {
    let peep: Peep
    
    var body: some View {
        VStack {
            DefaultProfilePicture()
            Text(peep.name)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
            Text(peep.emailAddress)
                .font(.body)
                .textCase(.lowercase)
                .foregroundColor(.secondary)
        }
    }
}

struct PeepHeader_Previews: PreviewProvider {
    static var previews: some View {
        PeepHeader(peep: Peep.peeper)
    }
}
