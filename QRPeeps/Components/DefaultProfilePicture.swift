//
//  DefaultProfilePicture.swift
//  QRPeeps
//
//  Created by William Dupont on 22/09/2022.
//

import SwiftUI

struct DefaultProfilePicture: View {
    var body: some View {
        Image(systemName: "person")
            .font(.system(size: 75))
            .frame(width: 150, height: 150)
            .foregroundColor(.gray)
            .background(.white)
            .clipShape(Circle())
            .shadow(radius: 10, x: 5, y: 5)
            .overlay(Circle().stroke(.gray, lineWidth: 4))
    }
}

struct DefaultProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        DefaultProfilePicture().preferredColorScheme(.dark)
        DefaultProfilePicture().preferredColorScheme(.light)
    }
}
