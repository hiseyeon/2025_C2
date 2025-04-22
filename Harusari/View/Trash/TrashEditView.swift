//
//  TrashEditView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/15/25.
//

import SwiftUI

struct TrashEditSelectableView: View {
    let goal: Goal
    let isSelecting: Bool
    let isSelected: Bool
    
    var onSelect: () -> Void = {}
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            //                   // 카드 자체
            TrashCardView(goal: goal)
                .contentShape(Rectangle()) // 빈 공간까지 탭 인식
                .onTapGesture {
                    if isSelecting {
                        onSelect()
                    }
                }
            
            if isSelecting {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.pink2)
                    .padding(.top, 50)
                    .padding(.horizontal, 16)
            }
        }
    }
}



//#Preview {
//    TrashEditPreviewWrapper()
//}
//
//private struct TrashEditPreviewWrapper: View {
//    @State private var isSelected = true
//    
//    var body: some View {
//        TrashEditSelectableView(
//            goal: Goal(
//                title: "정처기 시험 준비",
//                startDate: Date(),
//                endDate: Date().addingTimeInterval(86400 * 7),
//                progress: 0.5,
//                isTrashed: true
//            ),
//            isSelecting: true,
//            isSelected: isSelected,
//            onSelect: { isSelected.toggle() }
//        )
//    }
//}
