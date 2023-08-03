//
//  UserDefaultsController.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 03/08/23.
//

import Foundation


class UserDefaultsController: DataController {
    static let saveKey = "Cards"
    
    override init() {
        super.init()
        load()
    }
    
    override func add(_ card: Card) {
        cards.insert(card, at: 0)
        save()
    }
    
    override func remove(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        save()
    }
    
    override func load() {
        if let data = UserDefaults.standard.data(forKey: UserDefaultsController.saveKey) {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    override func save() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: UserDefaultsController.saveKey)
        }
    }
}
