//
//  PeepsView-ViewModel.swift
//  QRPeeps
//
//  Created by William Dupont on 23/09/2022.
//

import Foundation
import SwiftUI
import UserNotifications
import CodeScanner

extension PeepsView {
    @MainActor class ViewModel: ObservableObject {
        func addNotification(for peep: Peep) {
            let center = UNUserNotificationCenter.current()
            
            let addRequest = {
                let content = UNMutableNotificationContent()
                content.title = "Contact \(peep.name)"
                content.subtitle = peep.emailAddress
                content.sound = UNNotificationSound.default
                
                var dateComponents = DateComponents()
                dateComponents.hour = 9
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                center.add(request)
            }
            
            center.getNotificationSettings { settings in
                if settings.authorizationStatus == .authorized {
                    addRequest()
                } else {
                    center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            addRequest()
                        } else {
                            print("")
                        }
                    }
                }
            }
        }
        
        func handleScan(result: Result<ScanResult, ScanError>) {
//            self.isShowingScanner = false
            
            switch result {
            case .success(let result):
                let details = result.string.components(separatedBy: "\n")
                guard details.count == 2 else { return }
                
                let scannedPeep = Peep()
                scannedPeep.name = details[0]
                scannedPeep.emailAddress = details[1]
                
                // source of issue
                // UI not updating
                let peeps = Peeps.shared
                peeps.add(scannedPeep)
                
            case .failure(let error):
                print("Scanning failed: \(error.localizedDescription)")
            }
        }
    }
}
