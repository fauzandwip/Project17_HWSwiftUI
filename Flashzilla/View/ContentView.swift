//
//  ContentView.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 27/07/23.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithooutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject var vm: ContentViewModel
    @ObservedObject var dataController: DataController
    
    init(dataController: DataController) {
        _vm = StateObject(wrappedValue: ContentViewModel(dataController: dataController))
        _dataController = ObservedObject(initialValue: dataController)
    }
    
    var body: some View {
        ZStack {
            
            // MARK: - background
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            // MARK: - card and time
            VStack {
                
                // MARK: - time
                Text("Time: \(vm.timeRemaining)")
                    .font(.largeTitle)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                // MARK: - card
                    if vm.timeRemaining != 0 {
                        ZStack {
                            ForEach(vm.cards) { card in
                                CardView(card: card, contentVM: vm)
                                    .stacked(at: vm.index(for: card), in: vm.cards.count)
                                    .allowsHitTesting(vm.index(for: card) == vm.cards.count - 1)
                                    .accessibilityHidden(vm.index(for: card) < vm.cards.count - 1)
                            }
                        }
                        .allowsHitTesting(vm.timeRemaining > 0)
                    }
                
                // MARK: - start button
                if vm.cards.isEmpty || vm.timeRemaining == 0 {
                    Button("Start Again") { vm.resetCards() }
                    .padding()
                    .foregroundColor(.black)
                    .background(.white)
                    .clipShape(Capsule())
                    .padding(.vertical)
                }
            }
            
            // MARK: - edit button to navigate edit cards view
            VStack {
                HStack {
                    Spacer()
                    
                    ActionButton(systemImage: "plus.circle") {
                        vm.showEditScreen()
                    }
                }
                
                Spacer()
            }
            
            // MARK: - accessibility
            if differentiateWithooutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        // MARK: - incorrect button
                        ActionButton(systemImage: "xmark.circle") {
                            withAnimation {
                                vm.insertIncorrectCard(at: vm.cards.count - 1)
                            }
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        // MARK: - correct button
                        ActionButton(systemImage: "checkmark.circle") {
                            withAnimation {
                                vm.removeCard(at: vm.cards.count - 1)
                            }
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                }
            }
        }
        .onReceive(vm.timer, perform: vm.onReceiveTimer)
        .onChange(of: scenePhase, perform: vm.onChangeScenePhase)
        .sheet(isPresented: $vm.showingEditScreen, onDismiss: vm.resetCards) {
            EditCards(dataController: dataController)
        }
        .onAppear(perform: vm.resetCards)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dataController: UserDefaultsController())
    }
}
