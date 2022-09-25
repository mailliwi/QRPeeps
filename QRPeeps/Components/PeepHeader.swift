//
//  PeepHeader.swift
//  QRPeeps
//
//  Created by William Dupont on 22/09/2022.
//

import SwiftUI

struct PeepHeader: View {
    let peep: Peep
    
    func openEmailApp(toEmail: String, subject: String, body: String) {
        guard
            let subject = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let body = "Just testing ...".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        else {
            print("Error: Can't encode subject or body.")
            return
        }
        
        let urlString = "mailto:\(toEmail)?subject=\(subject)&body=\(body)"
        let url = URL(string:urlString)!
        
        UIApplication.shared.open(url)
    }
    
    var body: some View {
        VStack {
            DefaultProfilePicture()
            Text(peep.name)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
            Button {
                openEmailApp(toEmail: peep.emailAddress, subject: "Mail test subject", body: "Mail test body")
            } label: {
                Label(peep.emailAddress, systemImage: "envelope")
                    .textCase(.lowercase)
            }
        }
    }
}

struct PeepHeader_Previews: PreviewProvider {
    func onTap() -> Void { return }
    static var previews: some View {
        PeepHeader(peep: Peep.peeper)
    }
}
