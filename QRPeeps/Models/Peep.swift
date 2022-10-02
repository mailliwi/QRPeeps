//
//  Peep.swift
//  QRPeeps
//
//  Created by William Dupont on 15/09/2022.
//

import Foundation
import UIKit

class Peep: Identifiable, Codable {
    
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var description = ""
    var image: Data?
    fileprivate(set) var isContacted = false
    
    static var peeper: Peep = Peep(name: "Peeper Peepo", emailAddress: "peeper.peepo@mail.com")
    
    init(name: String, emailAddress: String) {
        self.name = name
        self.emailAddress = emailAddress
    }
    
    init() {

    }
}

@MainActor class Peeps: ObservableObject {
    @Published private(set) var people: [Peep]
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Peep].self, from: data) {
                self.people = decoded
                return
            }
        }
        
        self.people = []
    }
    
    func add(_ peep: Peep) {
        people.insert(peep, at: 0)
        saveToDocumentsDirectory()
    }
    
    func addDescription(for peep: Peep, description: String) {
        if let peep = self.people.first(where: { $0.id == peep.id }) {
            peep.description = description
        }
        
        saveToDocumentsDirectory()
    }
    
    func removeAll() {
        people = []
        try? FileManager.default.removeItem(at: savePath)
        UserDefaults.standard.synchronize()
        saveToDocumentsDirectory()
    }
    
    func toggleIsContacted(for peep: Peep) {
        objectWillChange.send()
        peep.isContacted.toggle()
        saveToDocumentsDirectory()
    }
    
    private func saveToDocumentsDirectory() {
        if let encoded = try? JSONEncoder().encode(self.people) {
            try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
}
