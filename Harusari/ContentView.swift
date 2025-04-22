//
//  ContentView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/14/25.
//

import SwiftUI
import SwiftData

@MainActor
struct ContentView: View {
    @Query var allGoals: [Goal]
    
    var body: some View {
        List {
            ForEach(allGoals) { goal in
                Text("📌 \(goal.title)")
            }
        }
//        .onAppear {
//            print("📋 전체 Goal 수: \(allGoals.count)")
//        }
    }
}

//
//#Preview {
//    ContentView()
//}
