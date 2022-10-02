//
//  PeepHeader-ViewModel.swift
//  QRPeeps
//
//  Created by William Dupont on 29/09/2022.
//

import Foundation
import SwiftUI

extension PeepHeader {
    @MainActor class ViewModel: ObservableObject {
        func mailTo(_ email: String) {
            let mailto = "mailto:\(email)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: mailto!)!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
}
