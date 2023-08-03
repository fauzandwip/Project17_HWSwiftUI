//
//  DataController.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 03/08/23.
//

import SwiftUI

class DataController: ObservableObject {
    @Published var cards = [Card]()

    func load() {}
    func save() {}
    func add(_ card: Card) {}
    func remove(at offsets: IndexSet) {}
}
