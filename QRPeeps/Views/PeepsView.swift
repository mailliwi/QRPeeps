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
    
    @StateObject var viewModel = ViewModel()
    
    let filter: PeepFilterType
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredPeeps) { peep in
                    NavigationLink(destination: DetailedPeepView(peep: peep)) {
                        PeepCard(peep: peep, filter: filter, isContacted: peep.isContacted)
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
                                viewModel.addNotification(for: peep)
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
        self.isShowingScanner = false
        
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
}
