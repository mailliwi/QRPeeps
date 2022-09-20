//
//  NoPeepsEmptyView.swift
//  QRPeeps
//
//  Created by William Dupont on 20/09/2022.
//

import SwiftUI
import Lottie

struct NoPeepsEmptyView: UIViewRepresentable {
    func makeUIView(context: Context) -> some AnimationView {
        let lottieAnimationView = AnimationView(name: "tumbleweed")
        lottieAnimationView.loopMode = .loop        
        lottieAnimationView.play()
        return lottieAnimationView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
