//
//  Peep.swift
//  QRPeeps
//
//  Created by William Dupont on 15/09/2022.
//

import Foundation

class Peep: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
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
    
    func removeAll() {
        people = []
        try? FileManager.default.removeItem(at: savePath)
        UserDefaults.standard.synchronize()
        saveToDocumentsDirectory()
    }
    
    private func saveToDocumentsDirectory() {
        if let encoded = try? JSONEncoder().encode(self.people) {
            try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
    
    func toggleIsContacted(for peep: Peep) {
        objectWillChange.send()
        peep.isContacted.toggle()
        saveToDocumentsDirectory()
    }
}
