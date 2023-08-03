//
//  ContentViewModel.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 02/08/23.
//

import SwiftUI
import Combine

@MainActor
class ContentViewModel: ObservableObject {
    
    @ObservedObject var dataController: DataController
    
    @Published private(set) var cards = [Card]()
    @Published var timeRemaining = 100
    @Published var isActive = false
    @Published var showingEditScreen = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(dataController: DataController) {
        _dataController = ObservedObject(initialValue: dataController)
        loadData()
    }
    
    // remove card without saving data
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        loadData()
        
        if cards.isEmpty {
            isActive = false
        } else {
            isActive = true
        }
    }
    
    func loadData() {
        cards = dataController.cards
    }
    
    func showEditScreen() {
        showingEditScreen = true
    }
    
    func index(for card: Card) -> Int {
        return cards.firstIndex(where: { $0.id == card.id }) ?? 0
    }
    
    func insertIncorrectCard(at index: Int) {
        let card = cards[index]
        
        removeCard(at: index)
        cards.insert(card, at: 0)
    }
    
    func onReceiveTimer(time: Publishers.Autoconnect<Timer.TimerPublisher>.Output) {
        guard isActive else { return }
        
        if timeRemaining > 0 {
            timeRemaining -= 1
        }
    }
    
    func onChangeScenePhase(newValue: ScenePhase) {
        if newValue == .active {
            if !cards.isEmpty {
                isActive = true
            }
        } else {
            isActive = false
        }
    }
}
