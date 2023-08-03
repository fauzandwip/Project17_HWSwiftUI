//
//  UserDefaultsController.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 03/08/23.
//

import Foundation


class UserDefaultsController: ObservableObject {
    static let saveKey = "Cards"
    
    @Published private(set) var cards = [Card]()
    
    init() {
        loadData()
    }
    
    func add(_ card: Card) {
        cards.insert(card, at: 0)
        saveData()
    }
    
    func remove(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: UserDefaultsController.saveKey) {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: UserDefaultsController.saveKey)
        }
    }
}
