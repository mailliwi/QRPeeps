//
//  PeepHeader.swift
//  QRPeeps
//
//  Created by William Dupont on 22/09/2022.
//

import SwiftUI

struct PeepHeader: View {
    @Environment(\.openURL) var openURL
    let peep: Peep
    
    func mailTo(_ email: String) {
        let mailto = "mailto:\(email)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: mailto!)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    var body: some View {
        VStack {
            DefaultProfilePicture()
            Button {
                mailTo(peep.emailAddress)
            } label: {
                Label(peep.emailAddress, systemImage: "envelope")
                    .textCase(.lowercase)
            }
        }
    }
}
