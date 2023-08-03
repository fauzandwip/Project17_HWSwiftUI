//
//  CardView.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 31/07/23.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @StateObject private var vm: CardViewModel
    
    init(card: Card, contentVM: ContentViewModel) {
        _vm = StateObject(wrappedValue: CardViewModel(card: card, contentVM: contentVM))
    }
    
    var body: some View {
        ZStack {
            
            // MARK: - square card
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(vm.offset.width) / 50)))
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                    /// first way
//                        .fill(offset.width > 0 ? .green : (offset.width == 0 ? .white : .red))
                    /// second way
                        .fill(vm.getBackgroundColor())
                )
                .shadow(radius: 10)
            
            // MARK: - card text
            VStack {
                if voiceOverEnabled {
                    Text(vm.isShowingAnswer ? vm.card.answer : vm.card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(vm.card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if vm.isShowingAnswer {
                        Text(vm.card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        // smallest iPhones have a landscape width of 480 points
        .frame(width: 450, height: 280)
        .rotationEffect(.degrees(Double(vm.offset.width / 5)))
        .offset(x: vm.offset.width * 5, y: 0)
        // start at 2 to keep it opaque until reaching 50 points
        .opacity(2 - Double(abs(vm.offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(vm.dragGesture())
        .onTapGesture { vm.isShowingAnswer.toggle() }
        .animation(.spring(), value: vm.offset)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example, contentVM: ContentViewModel(dataController: UserDefaultsController()))
    }
}
