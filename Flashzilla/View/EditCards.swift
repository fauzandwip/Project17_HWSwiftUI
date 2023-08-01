//
//  EditCards.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 01/08/23.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var promptText = ""
    @State private var answerText = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("New Card") {
                    TextField("prompt", text: $promptText)
                    TextField("answer", text: $answerText)
                    Button("Add Card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }
    }
    
    func done() {
        dismiss()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: ContentView.saveKey) {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: ContentView.saveKey)
        }
    }
    
    func addCard() {
        // delete spaces before and after full text
        // example: "  Taylor Swift  "" => "Taylor Swift"
        let trimmedPrompt = promptText.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = answerText.trimmingCharacters(in: .whitespaces)
        guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
        
        promptText = ""
        answerText = ""
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
