//
//  DocumentController.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 03/08/23.
//

import Foundation

class DocumentController: DataController {
    let url = FileManager.docDirectory.appendingPathComponent("SaveData.json")
    
    override init() {
        super.init()
        load()
    }
    
    override func load() {
        if let data = try? Data(contentsOf: url) {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    override func save() {
        do {
            let encoded = try JSONEncoder().encode(cards)
            try encoded.write(to: url)
        } catch {
            print("Failed save data to document directory: \(error.localizedDescription)")
        }
    }
    
    override func add(_ card: Card) {
        cards.insert(card, at: 0)
        save()
    }
    
    override func remove(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        save()
    }
}
