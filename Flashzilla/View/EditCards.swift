//
//  EditCards.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 01/08/23.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var vm: EditCardsViewModel
    
    init(dataController: DataController) {
        _vm = StateObject(wrappedValue: EditCardsViewModel(dataController: dataController))
    }
    
    
    var body: some View {
        NavigationView {
            List {
                // MARK: - add card section
                Section("New Card") {
                    TextField("prompt", text: $vm.promptText)
                    TextField("answer", text: $vm.answerText)
                    Button("Add Card") {
                        withAnimation {
                            vm.addCard()
                        }
                    }
                }
                
                // MARK: - list card section
                Section(vm.dataController.cards.count > 1 ? "Cards" : "Card") {
                    ForEach(vm.dataController.cards) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            Text(card.answer)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete { vm.removeCards(at: $0) }
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done") { dismiss() }
            }
            .listStyle(.grouped)
            .onAppear { vm.loadData() }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditCards(dataController: UserDefaultsController())
    }
}
