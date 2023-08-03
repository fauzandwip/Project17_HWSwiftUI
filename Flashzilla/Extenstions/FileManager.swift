//
//  FileManager.swift
//  Flashzilla
//
//  Created by Fauzan Dwi Prasetyo on 03/08/23.
//

import Foundation


extension FileManager {
    static var docDirectory: URL {
        let paths = self.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
