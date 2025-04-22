//
//  HarusariApp.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/14/25.
//

import SwiftUI

@main
struct HarusariApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: Goal.self)
    }
}

