//
//  GoalDetailView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/14/25.
//

// MARK: - 상세보기

import SwiftUI

struct GoalDetailView: View {
    
    let goal: Goal
    
    @Binding var isEditing: Bool
    @State private var editedTitle: String
    @State private var editedMemo: String = ""
    @State private var editedStartDate: Date
    @State private var editedEndDate: Date
    
    @State private var weeklyPlans: [String] = []
    
    init(goal: Goal, isEditing: Binding<Bool>) {
        self.goal = goal
        self._isEditing = isEditing
        _editedTitle = State(initialValue: goal.title)
        _editedMemo = State(initialValue: goal.memo ?? "")
        _editedStartDate = State(initialValue: goal.startDate)
        _editedEndDate = State(initialValue: goal.endDate)
    }
    private var progress: Double {
        let total = goal.weeklyPlans.count
        guard total > 0 else { return 0 }
        let completed = goal.weeklyPlans.filter { $0.isChecked }.count
        return Double(completed) / Double(total)
    }
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height


    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 16) {
                Text("달성률")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.top, 8)

                ZStack(alignment: .leading) {
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color.gray1)
                            .frame(height: 27)

                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color.black0)
                            .frame(width: geometry.size.width * CGFloat(progress), height: 27)
                    }
                    .frame(height: 27) // 고정 높이 지정
                }
                .overlay(
                    Text("\(Int(progress * 100))%")
                        .foregroundColor(.pink3)
                        .font(.subheadline)
                        .padding(.trailing, 12),
                    alignment: .trailing
                )
            }
            .padding(.bottom, 32)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)

            VStack(alignment: .leading, spacing: 16) {
                EditableBox(title: "제목", content: $editedTitle, isEditing: isEditing)
                    .padding(.bottom, 32)
                
                // 기간
                if isEditing {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("기간")
                            .font(.system(size: 16, weight: .semibold))
                        DatePicker("시작일", selection: $editedStartDate, displayedComponents: .date)
                        DatePicker("종료일", selection: $editedEndDate, displayedComponents: .date)
                    }
                } else {
                    LabeledBox(
                        title: "기간",
                        content: "\(formatted(editedStartDate)) → \(formatted(editedEndDate))"
                    )
                }
                
                // 메모
                EditableBox(title: "메모", content: $editedMemo, isEditing: isEditing, isMemo: true)
                    .padding(.vertical, 32)
            }
            .listRowInsets(EdgeInsets())
            
            ForEach(goal.weeklyPlans.sorted(by: { $0.week < $1.week })) { plan in
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(plan.week)주차")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .padding(.vertical, 12)

                    HStack {
                        TextField("\(plan.week)주차 계획을 입력하세요", text: Binding(
                            get: { plan.content },
                            set: { plan.content = $0 }
                        ), axis: .vertical)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray2)
                        )
                        Button(action: {
                            plan.isChecked.toggle()
                        }) {
                            Image(systemName: plan.isChecked ? "checkmark.circle.fill" : "checkmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.pink3)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        if let index = goal.weeklyPlans.firstIndex(where: { $0.id == plan.id }) {
                            goal.weeklyPlans.remove(at: index)
                        }
                    } label: {
                        Label("삭제", systemImage: "trash")
                        
                    }
                }
//                .listStyle(.plain)

                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }

            VStack {
                Button(action: {
                    let newWeek = (goal.weeklyPlans.map { $0.week }.max() ?? 0) + 1
                    let newPlan = WeeklyPlan(week: newWeek, content: "", isChecked: false, goal: goal)
                    goal.weeklyPlans.append(newPlan)
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("주간 계획 추가하기")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black0)
                    .cornerRadius(12)
                }
                .padding(.top, 32)
                .buttonStyle(.plain)
                
//                Spacer()
            }
//            .padding(.horizontal, 16)
//        }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .listStyle(.plain)
        .padding(.horizontal, 16)
    }
    
    
    private func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
        
//        private var progressBarWidth: CGFloat {
//            UIScreen.main.bounds.width * 0.7 * goal.progress
//    private var progressBarWidth: CGFloat {
//        UIScreen.main.bounds.width * 0.7 * goal.progress
//        }
    }


struct LabeledBox: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))

            Text(content)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray2)
                )
        }
    }
}


struct EditableBox: View {
    let title: String
    @Binding var content: String
    var isEditing: Bool
    var isMemo: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))

            if isEditing {
                if isMemo {
                    TextEditor(text: $content)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(minHeight: 100)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray2))
                } else {
                    TextField("입력하세요", text: $content)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray2))
                }
            } else {
                Text(content)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray2)
                    )
            }
        }
    }
}


#Preview {
    GoalDetailView(goal: Goal(
        title: "정처기 시험 준비",
        startDate: Date(),
        endDate: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
        progress: 0.5,
        memo: "정처기 필기 시험 준비 중"
//    ))
    ), isEditing: .constant(false))
}

