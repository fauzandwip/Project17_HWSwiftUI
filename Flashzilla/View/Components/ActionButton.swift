//
//  ActionButton.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 02/08/23.
//

import SwiftUI

struct ActionButton: View {
    let systemImage: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .padding()
                .font(.largeTitle)
                .foregroundColor(.white)
                .background(.black.opacity(0.7))
                .clipShape(Circle())
                .padding()
        }
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(systemImage: "plus.circle", action: { print("Hello") })
    }
}
