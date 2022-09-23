//
//  PeepsView.swift
//  QRPeeps
//
//  Created by William Dupont on 15/09/2022.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct PeepsView: View {
    @EnvironmentObject var peeps: Peeps
    @State private var isShowingScanner = false
    @State private var isShowingAlert = false
    @State private var sortOrder: PeepSortType = .date
    @State private var isShowingSortOptions = false
    
    let filter: PeepFilterType
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredPeeps) { peep in
                    NavigationLink(destination: DetailedPeepView(peep: peep)) {
                        PeepCard(peep: peep, filter: filter)
                    }
                    .swipeActions {
                        if peep.isContacted {
                            Button {
                                peeps.toggleIsContacted(for: peep)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                peeps.toggleIsContacted(for: peep)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: peep)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                }
                }
            }
            .navigationTitle(title)
            .emptyListPlaceholder(condition: peeps.people.isEmpty)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if peeps.people.isEmpty {
                        EmptyView()
                    } else {
                        Button {
                            isShowingAlert = true
                        } label: {
                            Label("Empty peeps.people", systemImage: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        isShowingSortOptions = true
                    } label: {
                        Label("Sort peeps", systemImage: "slider.horizontal.3")
                    }
                    
                    Button {
                        isShowingScanner = true
                        
                        // for simulator purposes
                        // The following lines of code simulate adding a peep to your list
                        // Needs deleted if planning to use on a real device, otherwise this dummy
                        // peep will be added on top of the scanned accounts
                        
//                        let peep = Peep()
//                        peep.name = "Kiwiwi"
//                        peep.emailAddress = "testemail"
//                        peeps.add(peep)
                        
                    } label: {
                        Label("Scan QR Code", systemImage: "qrcode.viewfinder")
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], completion: handleScan)
            }
            .confirmationDialog("Sort peeps by", isPresented: $isShowingSortOptions) {
                Button("Name (A-Z)") { sortOrder = .name }
                Button("Date (Newest to Oldest)") { sortOrder = .date }
            } message: {
                Text("Sort peeps by...")
            }
            .alert("Delete all peeps?", isPresented: $isShowingAlert, actions: {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    peeps.removeAll()
                }
            }, message: {
                Text("By pressing 'delete', your list of peeps will be cleared out.\n\nThis action is irreversible.\nDo you wish to continue?")
            })
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "All peeps"
        case .contacted:
            return "Contacted peeps"
        case .uncontacted:
            return "Peeps to contact"
        }
    }
    
    var filteredPeeps: [Peep] {
        let result: [Peep]
        
        switch filter {
        case .none:
            result = peeps.people
        case .contacted:
            result = peeps.people.filter { $0.isContacted }
        case .uncontacted:
            result = peeps.people.filter { !$0.isContacted }
        }
        
        if sortOrder == .name {
            return result.sorted { $0.name < $1.name }
        } else {
            return result
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let scannedPeep = Peep()
            scannedPeep.name = details[0]
            scannedPeep.emailAddress = details[1]
            peeps.add(scannedPeep)
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
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
}
