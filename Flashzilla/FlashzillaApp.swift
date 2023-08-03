//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 27/07/23.
//

import SwiftUI

@main
struct FlashzillaApp: App {
    @StateObject var dataController = UserDefaultsController()
    
    var body: some Scene {
        WindowGroup {
            ContentView(dataController: dataController)
        }
    }
}
