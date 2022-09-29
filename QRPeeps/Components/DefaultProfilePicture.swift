//
//  DefaultProfilePicture.swift
//  QRPeeps
//
//  Created by William Dupont on 22/09/2022.
//

import SwiftUI

struct DefaultProfilePicture: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(systemName: "person")
                .font(.system(size: 75))
                .frame(width: 150, height: 150)
                .foregroundColor(.gray)
                .background(.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(.gray, lineWidth: 4))
            
            Button {
                
            } label: {
                Image(systemName: "square.and.pencil")
            }
        }
    }
}

struct DefaultProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        DefaultProfilePicture().preferredColorScheme(.dark)
        DefaultProfilePicture().preferredColorScheme(.light)
    }
}
