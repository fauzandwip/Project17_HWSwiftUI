//
//  UserInteractivityView.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 28/07/23.
//

import SwiftUI

struct UserInteractivityView: View {
    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(.blue)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Rectangle Tapped!")
//                }
//
//            Circle()
//                .fill(.red)
//                .contentShape(Rectangle())
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Circle Tapped!")
//                }
////                .allowsHitTesting(false)
//        }
        
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World!")
        }
        .contentShape(Rectangle())
        // or
//        .background()
        .onTapGesture {
            print("VStack Tapped!")
        }
    }
}

struct UserInteractivityView_Previews: PreviewProvider {
    static var previews: some View {
        UserInteractivityView()
    }
}
