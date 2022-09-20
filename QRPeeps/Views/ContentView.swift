//
//  ContentView.swift
//  QRPeeps
//
//  Created by William Dupont on 13/09/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var peeps = Peeps()
    
    var body: some View {
        TabView {
            PeepsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            PeepsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            PeepsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.square")
                }
        }
        .environmentObject(peeps)
    }
}
