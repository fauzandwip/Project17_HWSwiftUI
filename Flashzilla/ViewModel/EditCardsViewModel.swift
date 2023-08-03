//
//  EditCardsViewModel.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 03/08/23.
//

import SwiftUI

@MainActor
class EditCardsViewModel: ObservableObject {
    @ObservedObject var dataController: UserDefaultsController
    @Published var promptText = ""
    @Published var answerText = ""
    
    init(dataController: UserDefaultsController) {
        _dataController = ObservedObject(initialValue: dataController)
    }
    
    func loadData() {
        dataController.loadData()
    }
    
    func addCard() {
        // delete spaces before and after full text
        // example: "  Taylor Swift  "" => "Taylor Swift"
        let trimmedPrompt = promptText.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = answerText.trimmingCharacters(in: .whitespaces)
        guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        dataController.add(card)
        
        promptText = ""
        answerText = ""
    }
    
    func removeCards(at indexSet: IndexSet) {
        dataController.remove(at: indexSet)
    }
}
