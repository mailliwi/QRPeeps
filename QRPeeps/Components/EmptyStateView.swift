//
//  EmptyStateView.swift
//  QRPeeps
//
//  Created by William Dupont on 20/09/2022.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Text("Whoops...")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding()
            Text("""
                     Looks like you have not added anyone to your list... just yet.\n
                     Add people to your contacts by scanning their QR code with the button at the top right of your screen!
                """)
            .foregroundColor(.secondary)
            
            
            LottieView(fileName: "tumbleweed")
                .frame(width: 300, height: 150)
                .padding()
        }
        .padding()
        .multilineTextAlignment(.center)
    }
}
