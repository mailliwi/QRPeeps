//
//  PeepProfilePicture.swift
//  QRPeeps
//
//  Created by William Dupont on 02/10/2022.
//

import SwiftUI

struct PeepProfilePicture: View {
    let peep: Peep
    @Binding var image: UIImage
    
    func fetchPeepImage() {
            if let dataImage = UIImage(data: peep.image!) {
                image = dataImage
            }
        }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay(Circle().stroke(.gray, lineWidth: 4))
            .onAppear(perform: fetchPeepImage)
    }
}
