//
//  AccessibilityView.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 31/07/23.
//

import SwiftUI

struct AccessibilityView: View {
    // MARK: - accessibilityDifferentiateWithoutColor
//    @Environment(\.accessibilityDifferentiateWithoutColor) var aDWF
//
//    var body: some View {
//        HStack {
//            if aDWF {
//                Image(systemName: "checkmark.circle")
//            }
//
//            Text("Success")
//        }
//        .padding()
//        .background(aDWF ? .black : .green)
//        .foregroundColor(.white)
//        .clipShape(Capsule())
    
//    // MARK: - accessibilityReduceMotion
//    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
//        if UIAccessibility.isReduceMotionEnabled {
//            return try body()
//        } else {
//            return try withAnimation(animation, body)
//        }
//    }
    
//    @Environment(\.accessibilityReduceMotion) var aRM
//    @State private var scale = 1.0
//
//    var body: some View {
//        Text("Hello World!")
//            .scaleEffect(scale)
//            .onTapGesture {
//                withOptionalAnimation {
//                    scale *= 1.5
//                }
//            }
//    }
    
    // MARK: - accessibilityReduceTransparency
    @Environment(\.accessibilityReduceTransparency) var aRT
    
    var body: some View {
        Text("Hello World!")
            .padding()
            .background(aRT ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct AccessibilityView_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityView()
    }
}
