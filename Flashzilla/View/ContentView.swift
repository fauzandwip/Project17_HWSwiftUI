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
    
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    @State private var isActive = false
    @State private var showingEditScreen = false
    
    static let saveKey = "Cards"
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            
            // MARK: - background
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            // MARK: - card and time
            VStack {
                
                // MARK: - time
                Text("Time: \(timeRemaining)")
                    .font(.title)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                // MARK: - card
                ZStack {
                    ForEach(cards) { card in
                        CardView(card: card) { isIncorrect in
                            if isIncorrect {
                                withAnimation {
                                    insertIncorrectCard(at: self.index(for: card))
                                }
                            } else {
                                withAnimation {
                                    removeCard(at: self.index(for: card))
                                }
                            }
                            
                        }
                        .stacked(at: self.index(for: card), in: cards.count)
                        .allowsHitTesting(self.index(for: card) == cards.count - 1)
                        .accessibilityHidden(self.index(for: card) < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                // MARK: - start button
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .foregroundColor(.black)
                        .background(.white)
                        .clipShape(Capsule())
                        .padding(.vertical)
                }
            }
            
            // MARK: - plus button to navigate edit cards view
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    .padding()
                    .font(.title)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.7))
                    .clipShape(Circle())
                    .padding()
                }
                
                Spacer()
            }
            
            // MARK: - accessibility
            if differentiateWithooutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        // MARK: - incorrect button
                        Button {
                            withAnimation {
                                insertIncorrectCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        
                        // MARK: - correct button
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                }
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newValue in
            if newValue == .active {
                if !cards.isEmpty {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
    }
    
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
    
    func index(for card: Card) -> Int {
        return cards.firstIndex(where: { $0.id == card.id }) ?? 0
    }
    
    func insertIncorrectCard(at index: Int) {
        let card = cards[index]
        
        removeCard(at: index)
        cards.insert(card, at: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
