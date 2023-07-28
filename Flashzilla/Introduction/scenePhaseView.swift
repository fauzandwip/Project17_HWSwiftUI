//
//  scenePhaseView.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 28/07/23.
//

import SwiftUI

struct scenePhaseView: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onChange(of: scenePhase) { newValue in
                // active scene
                if newValue == .active {
                    print("Active")
                    // scene visible but can't touch
                } else if newValue == .inactive {
                    print("Inactive")
                    // scene not visible
                } else if newValue == .background {
                    print("Background")
                }
            }
    }
}

struct scenePhaseView_Previews: PreviewProvider {
    static var previews: some View {
        scenePhaseView()
    }
}
