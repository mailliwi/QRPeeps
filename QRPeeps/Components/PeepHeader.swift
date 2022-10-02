//
//  PeepHeader.swift
//  QRPeeps
//
//  Created by William Dupont on 22/09/2022.
//

import SwiftUI

struct PeepHeader: View {
    let peep: Peep
    
    @Environment(\.openURL) var openURL
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                DefaultProfilePicture()
                Button {
                    // show imagepicker
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
            .padding(.bottom, 12)
            
            Button {
                viewModel.mailTo(peep.emailAddress)
            } label: {
                Label(peep.emailAddress, systemImage: "envelope")
                    .textCase(.lowercase)
            }
        }
    }
}
