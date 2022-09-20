//
//  NoPeepsEmptyView.swift
//  QRPeeps
//
//  Created by William Dupont on 20/09/2022.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var fileName: String
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> some UIView {
        
        let view = UIView(frame: .zero)
        
        let lottieAnimationView = AnimationView(name: fileName)
        
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.play()
        
        lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lottieAnimationView)
        
        NSLayoutConstraint.activate([
            lottieAnimationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            lottieAnimationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieView>) {
        
    }
}
