//
//  GoalEmptyView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/15/25.
//

import SwiftUI

struct GoalEmptyView: View {
    
    @State private var selectedFilter: GoalFilter = .all
    
    var body: some View {
        VStack {
//            TopTabView(selectedFilter: $selectedFilter)
            
            Text("엥 . . . ?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.top, 52)
            
            Spacer()
            
        }
    }
}

#Preview {
    GoalEmptyView()
}
