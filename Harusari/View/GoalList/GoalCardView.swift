//
//  GoalCardView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/14/25.
//

// MARK: - 목표 List 한 개의 View

import SwiftUI

struct GoalCardView: View {
    
    let goal: Goal
    
    var body: some View {
//        NavigationStack{
            NavigationLink(value: goal) {
                
                VStack(alignment: .leading) {
                    Text(goal.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    Text("\(formatted(goal.startDate)) → \(formatted(goal.endDate))")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding(.bottom)
                    
                    ZStack(alignment: .leading) {
                        GeometryReader { geometry in
                            let fullWidth = geometry.size.width

                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color.gray1)
                                .frame(width: fullWidth, height: 27)

                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color.black0)
                                .frame(width: fullWidth * progress, height: 27)
                        }
                        .frame(height: 27)
                    }
                    .overlay(
                        Text("\(Int(progress * 100))%")
                            .foregroundColor(.pink3)
                            .font(.subheadline)
                            .padding(.trailing, 12),
                        alignment: .trailing
                    )
//                    ZStack(alignment: .leading) {
//                        RoundedRectangle(cornerRadius: 100)
//                            .fill(Color.gray1)
//                            .frame(height: 27)
//                        
//                        RoundedRectangle(cornerRadius: 100)
//                            .fill(Color.black0)
//                            .frame(width: progressBarWidth, height: 27)
//                    }
//                    .overlay(
////                        Text("\(Int(goal.progress * 100))%")
//                        Text("\(Int(progress * 100))%")
//                        .foregroundColor(.pink3)
//                            .font(.subheadline)
//                            .padding(.trailing, 12),
//                        alignment: .trailing
//                    )
                }
                //            .padding(.horizontal, 16)
                //            .padding(.vertical, 6)
            }
            .padding(.vertical, 22)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray2)
            )
        }
//    }
    
    private var progress: Double {
        let total = goal.weeklyPlans.count
        guard total > 0 else { return 0 }
        let completed = goal.weeklyPlans.filter { $0.isChecked }.count
        return Double(completed) / Double(total)
    }
    
    
    private var progressBarWidth: CGFloat {
//        UIScreen.main.bounds.width * 0.7 * goal.progress
        UIScreen.main.bounds.width * 0.7 * progress
    }
    
    private func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}

//#Preview {
//
//    GoalCardView(
//    )
//
//}
