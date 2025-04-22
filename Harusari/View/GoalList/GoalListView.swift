//
//  GoalListView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/14/25.
//

// MARK: - List page


import SwiftUI
import SwiftData

struct GoalListView: View {
    @State private var selectedFilter: GoalFilter = .all
    //    @Query var goals: [Goal]
//    @Query(filter: #Predicate<Goal> { !$0.isTrashed }) var goals: [Goal]
    @Query private var allGoals: [Goal]
    
    private var filteredGoals: [Goal] {
        let now = Date()
        switch selectedFilter {
        case .all:
            return allGoals.filter { !$0.isTrashed }
        case .inProgress:
            return allGoals.filter { !$0.isTrashed && $0.endDate >= now }
        case .completed:
            return allGoals.filter { !$0.isTrashed && $0.endDate < now }
        }
    }
    
    @State private var navResetTrigger = UUID()
    @Binding var showWriteView: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                TopTabView(selectedFilter: $selectedFilter)
                
                
//                if goals.isEmpty {
                    if filteredGoals.isEmpty {
                    GoalEmptyView()
                        .padding(.top, 50)
                } else {
                    List {
//                        ForEach(goals) { goal in
                        ForEach(filteredGoals) { goal in
                            GoalCardView(goal: goal)
                            .buttonStyle(.plain)
                            .listRowSeparator(.hidden)
                            .swipeActions {
                                Button {
                                    goal.isTrashed = true // 휴지통으로 이동
                                } label: {
                                    Image("trashButtom")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    
                                }
                                .tint(.clear)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .navigationDestination(for: Goal.self) { goal in
                        GoalDetailView(goal: goal)
                            .navigationTitle("상세보기")
                            .toolbar(.hidden, for: .tabBar)
//                            .toolbar {
//                                ToolbarItem(placement: .topBarTrailing) {
//                                    Button(action: {
//                                        isEditing.toggle()
//                                    }) {
//                                        Text(isEditing ? "완료" : "편집")
//                                    }
//                                }
//                            }
                    }
                }
            }
//            .onAppear {
//                print("현재 저장된 목표 수: \(goals.count)")
//                for goal in goals {
//                    print("📌 \(goal.title)")
//                }
//            }
        }
        .id(navResetTrigger)
        .onChange(of: showWriteView) { newValue in
            if newValue == false {
                navResetTrigger = UUID() // 네비게이션 스택 초기화
            }
        }
    }
}

//#Preview {
//    PreviewGoalListWrapper()
//}


//private struct PreviewGoalListWrapper: View {
//    var body: some View {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try! ModelContainer(for: Goal.self, configurations: config)
//        
//        let sampleGoal = Goal(
//            title: "프리뷰 테스트 목표",
//            startDate: Date(),
//            endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
//            progress: 0.5,
//            memo: "샘플 메모"
//        )
//        container.mainContext.insert(sampleGoal)
//        
//        return GoalListView(showWriteView: $showWriteView)
//            .modelContainer(container)
//    }
//}
