//
//  CardViewModel.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 02/08/23.
//

import SwiftUI

@MainActor
class CardViewModel: ObservableObject {
    @ObservedObject var contentVM: ContentViewModel

    @Published var isShowingAnswer = false
    @Published var offset = CGSize.zero
    @Published var feedback = UINotificationFeedbackGenerator()
    
    let card: Card
    
    init(card: Card, contentVM: ContentViewModel) {
        self.card = card
        _contentVM = ObservedObject(initialValue: contentVM)
    }
    
    func getBackgroundColor() -> Color {
        if offset.width > 0 {
            return Color.green
        }
        
        if offset.width < 0 {
            return Color.red
        }
        
        return Color.white
    }
    
    func dragGesture() -> some Gesture {
        DragGesture()
            .onChanged { gesture in
                self.offset = gesture.translation
                self.feedback.prepare()
            }
            .onEnded { _ in
                if abs(self.offset.width) > 100 {
                    
//                    removal?(offset.width < 0)
                    if self.offset.width < 0 {
                        withAnimation {
                            self.contentVM.insertIncorrectCard(at: self.contentVM.index(for: self.card))
                        }
                    } else {
                        withAnimation {
                            self.contentVM.removeCard(at: self.contentVM.index(for: self.card))
                        }
                    }
                    
                    if self.offset.width < 0 {
                        self.feedback.notificationOccurred(.error)
                        
                        self.isShowingAnswer = false
                        self.offset = .zero
                    }
                    
                    
                } else {
                    self.offset = .zero
                }
            }
    }
}
