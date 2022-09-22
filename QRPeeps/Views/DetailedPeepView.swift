//
//  DetailedPeepView.swift
//  QRPeeps
//
//  Created by William Dupont on 22/09/2022.
//

import SwiftUI

struct DetailedPeepView: View {
    let peep: Peep
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            PeepHeader(peep: peep)
            VStack(alignment: .leading, spacing: 12) {
                Divider()
                Text("To come for this page:")
                    .font(.headline)
                    .fontWeight(.bold)
                Text("Ability for user to enter description of the selected peep, similar to the Notes app.\n\nAbility for user to send email to selected peep by tapping the email in the link above.\n\nAbility for user to set a profile picture for the selected peep.")
                .foregroundColor(.secondary)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
        }
        .frame(maxWidth: .infinity)
    }
}

struct DetailedPeepView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedPeepView(peep: Peep.peeper).preferredColorScheme(.dark)
        DetailedPeepView(peep: Peep.peeper).preferredColorScheme(.light)
    }
}
