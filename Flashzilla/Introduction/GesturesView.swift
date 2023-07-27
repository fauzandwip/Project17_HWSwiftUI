//
//  GesturesView.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 27/07/23.
//

import SwiftUI

struct GesturesView: View {
    /// scale
//    @State private var currentAmount = 0.0
//    @State private var finalAmount = 1.0
    
    /// rotate
//    @State private var currentAmount = Angle.zero
//    @State private var finalAmount = Angle.zero
    
    /// sequence
    // how far the circle has been dragged
    @State private var offset = CGSize.zero
    // whether it is currently being dragged or not
    @State private var isDragging = false
    
    var body: some View {
        VStack {
            // MARK: - TapGesture with count parameter in second
//            CustomText(text: "Tap Gesture: count 2")
//                .onTapGesture(count: 2) {
//                    print("Double Tapped!")
//                }
            
            // MARK: - LongPressGesture with onPressingChanged
//            CustomText(text: "Long Pressed!")
//                .onLongPressGesture(minimumDuration: 1) {
//                    print("Long Pressed!")
//                } onPressingChanged: { inProgress in
//                    print("In Progress: \(inProgress)")
//                }
            
            // MARK: - ScaleEffect and MagnificationGesture
//            CustomText(text: "Scale Effect & MagnificationGesture")
//                .scaleEffect(finalAmount + currentAmount)
//                .gesture(
//                    MagnificationGesture()
//                        .onChanged { amount in
//                            print(amount)
//                            currentAmount = amount - 1
//                        }
//                        .onEnded { amount in
//                            finalAmount += currentAmount
//                            currentAmount = 0
//                        }
//                )
            
            // MARK: - RotationEffect and RotationGesture
//            CustomText(text: "Rotation and RotationGesture")
//                .rotationEffect(finalAmount + currentAmount)
//                .gesture(
//                    RotationGesture()
//                        .onChanged { angle in
//                            print(angle)
//                            currentAmount = angle
//                        }
//                        .onEnded { angle in
//                            print("current: \(currentAmount)")
//                            print(angle)
//                            finalAmount += currentAmount
//                            currentAmount = .zero
//                        }
//                )
            
            // MARK: - Gestures Clash
//            VStack {
//                CustomText(text: "Priority")
//                    .onTapGesture {
//                        print("Text Tapped!")
//                    }
//            }
//            .onTapGesture {
//                print("VStack Tapped!")
//            }
            /// will trigger
//            .highPriorityGesture(
//                TapGesture()
//                    .onEnded { _ in
//                        print("VStack Tapped!")
//                    }
//            )
            /// both trigger
//            .simultaneousGesture(
//                TapGesture()
//                    .onEnded { _ in
//                        print("VStack Tapped!")
//                    }
//            )
            
            // MARK: - Sequence
            // a drag gesture that updates offset and isDragging as it moves around
            let dragGesture = DragGesture()
                .onChanged { value in offset = value.translation }
                .onEnded { _ in
                    withAnimation {
                        offset = .zero
                        isDragging = false
                    }
                }
            
            // a long press gesture that enables isDragging
            let pressGesture = LongPressGesture()
                .onEnded { _ in
                    withAnimation {
                        isDragging = true
                    }
                }
            
            // a combined gesture that forces the user to long press then drag
            let combined = pressGesture.sequenced(before: dragGesture)
            
            Circle()
                .fill(.red)
                .frame(width: 64, height: 64)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(combined)
        }
    }
}

struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .padding()
            .background(.cyan)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct GesturesView_Previews: PreviewProvider {
    static var previews: some View {
        GesturesView()
    }
}
