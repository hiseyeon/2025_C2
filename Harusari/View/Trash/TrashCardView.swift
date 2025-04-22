//
//  TrashCardView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/18/25.
//

import SwiftUI

struct TrashCardView: View {
    let goal: Goal

    var body: some View {
        VStack(alignment: .leading) {
            Text(goal.title)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.bottom)
//                .foregroundColor(.black)

            Text("\(formatted(goal.startDate)) → \(formatted(goal.endDate))")
                .font(.subheadline)
                .foregroundColor(.black)
//                .padding(.bottom)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 24)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray2)
        )
//        .padding(.horizontal, 16)
//        .padding(.vertical, 6)
    }

    private func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}


//#Preview {
//    VStack {
//        TrashCardView(goal: Goal(
//            title: "정처기 시험 준비",
//            startDate: Date(),
//            endDate: Date().addingTimeInterval(86400 * 7),
//            progress: 0.5,
//            isTrashed: true
//        ))
//
//        TrashCardView(goal: Goal(
//            title: "졸업 작품 아이디어 구상",
//            startDate: Date().addingTimeInterval(-86400 * 14),
//            endDate: Date().addingTimeInterval(86400 * 14),
//            progress: 0.3,
//            isTrashed: true
//        ))
//    }
////    .padding()
//}
