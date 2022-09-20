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
    let saveKey: String = "SavedData"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Peep].self, from: data) {
                self.people = decoded
                return
            }
        }
        
        self.people = []
    }
    
    func add(_ peep: Peep) {
        people.insert(peep, at: 0)
        saveToUserDefaults()
    }
    
    func removeAll() {
        people = []
        UserDefaults.standard.removeObject(forKey: saveKey)
        UserDefaults.standard.synchronize()
        saveToUserDefaults()
    }
    
    private func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(self.people) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func toggleIsContacted(for peep: Peep) {
        objectWillChange.send()
        peep.isContacted.toggle()
        saveToUserDefaults()
    }
}
