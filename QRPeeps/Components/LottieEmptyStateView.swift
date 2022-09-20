//
//  NoPeepsEmptyView.swift
//  QRPeeps
//
//  Created by William Dupont on 20/09/2022.
//

import SwiftUI
import Lottie

struct LottieEmptyStateView: UIViewRepresentable {
    var fileName: String
    
    func makeUIView(context: UIViewRepresentableContext<LottieEmptyStateView>) -> some UIView {
        
        let view = UIView(frame: .zero)
        
        let lottieAnimationView = AnimationView()
        let animation = Animation.named(fileName)
        
        lottieAnimationView.animation = animation
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
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieEmptyStateView>) {
        
    }
}
