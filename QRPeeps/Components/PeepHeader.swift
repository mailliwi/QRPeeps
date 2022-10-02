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
    @EnvironmentObject var peeps: Peeps
    @StateObject var viewModel = ViewModel()
    
    @State private var isShowingImagePicker: Bool = false
    @State private var image = UIImage()
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                if peep.image == nil {
                    DefaultProfilePicture()
                } else {
                    PeepProfilePicture(peep: peep, image: $image)
                }
                
                Button {
                    isShowingImagePicker = true
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
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { uiimage in
                image = uiimage
                peeps.addProfilePicture(for: peep, image: uiimage)
            }
        }
    }
}
