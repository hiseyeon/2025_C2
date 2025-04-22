//
//  TopTabView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/15/25.
//

import SwiftUI

enum GoalFilter: String, CaseIterable, Identifiable {
    case all = "전체"
    case inProgress = "진행중"
    case completed = "종료"

    var id: String { self.rawValue }
}

struct TopTabView: View {
    
    @Binding var selectedFilter: GoalFilter

        var body: some View {
            VStack {
                HStack(alignment: .center, spacing: 20) {
                    ForEach(GoalFilter.allCases) { filter in
                        Spacer()
                        Button(action: {
                            selectedFilter = filter
                        }) {
                            Text(filter.rawValue)
                                .fontWeight(selectedFilter == filter ? .bold : .regular)
                                .foregroundColor(selectedFilter == filter ? .black : .gray)
                            
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
                
                
                Divider()
                    .background(Color.gray.opacity(0.3))
//                    .padding(.bottom, 32)
                    .padding(.top, 12)
            }
        }
    }

//
//  TopTabView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/15/25.
//
//
//import SwiftUI
//
//enum GoalFilter: String, CaseIterable, Identifiable {
//    case all = "전체"
//    case inProgress = "진행중"
//    case completed = "종료"
//
//    var id: String { self.rawValue }
//}
//
//struct TopTabView: View {
//    
//    @Binding var selectedFilter: GoalFilter
////
////        var body: some View {
////            VStack {
////                HStack(alignment: .center, spacing: 20) {
////                    ForEach(GoalFilter.allCases) { filter in
////                        Spacer()
////                        Button(action: {
////                            selectedFilter = filter
////                        }) {
////                            Text(filter.rawValue)
////                                .fontWeight(selectedFilter == filter ? .bold : .regular)
////                                .foregroundColor(selectedFilter == filter ? .black : .gray)
////
////                        }
////                        Spacer()
//    var body: some View {
//        VStack {
//            HStack(alignment: .center, spacing: 20) {
//                ForEach(GoalFilter.allCases) { filter in
//                    Spacer()
//                    Button(action: {
//                        selectedFilter = filter
//                    }) {
//                        Text(filter.rawValue)
//                            .fontWeight(selectedFilter == filter ? .bold : .regular)
//                            .foregroundColor(selectedFilter == filter ? .black : .gray)
//                        
//                    }
//                }
//                .padding(.horizontal, 20)
//                .padding(.top, 18)
//                
//                
//                Divider()
//                    .background(Color.gray.opacity(0.3))
////                    .padding(.bottom, 32)
//                    .padding(.top, 12)
//            }
//        }
//    }
//
//struct TopTabView_PreviewWrapper: View {
//    @State private var filter: GoalFilter = .all
//
//    var body: some View {
//        TopTabView(selectedFilter: $filter)
//    }
//}
//
//#Preview {
//    TopTabView_PreviewWrapper()
//}
//

struct TopTabView_PreviewWrapper: View {
    @State private var filter: GoalFilter = .all

    var body: some View {
        TopTabView(selectedFilter: $filter)
    }
}

#Preview {
    TopTabView_PreviewWrapper()
}

