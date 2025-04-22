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
    @Query(filter: #Predicate<Goal> { !$0.isTrashed }) var goals: [Goal]
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
    
    @State private var isEditing: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                TopTabView(selectedFilter: $selectedFilter)
                
                    if filteredGoals.isEmpty {
                    GoalEmptyView()
                        .padding(.top, 50)
                } else {
                    List {
                            ForEach(filteredGoals) { goal in
                                
//           MARK: NavigationLink 여기
//                                NavigationLink(value: goal) {
                                ForEach(filteredGoals) { goal in
                                    NavigationLink(value: goal) {
                                        GoalCardView(goal: goal)
                                            .buttonStyle(.plain)
                                    }
                                    .listRowSeparator(.hidden)
                                    .swipeActions {
                                        Button {
                                            goal.isTrashed = true
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
                    }
                    .listStyle(.plain)
                    
                    .navigationDestination(for: Goal.self) { goal in
                        GoalDetailView(goal: goal, isEditing: $isEditing)
                            .toolbar {
                                ToolbarItem(placement: .principal) {
                                    GoalDetailToolbar(isEditing: $isEditing)
                                }
                            }
//                            .navigationTitle("상세보기")
//                            .toolbar(.hidden, for: .tabBar)
                    }
                }
            }
        }
        .id(navResetTrigger)
    }
}

#Preview {
    PreviewGoalListWrapper()
}


private struct PreviewGoalListWrapper: View {
    @State private var showWriteView = false

    var body: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Goal.self, configurations: config)
        
        let sampleGoal = Goal(
            title: "프리뷰 테스트 목표",
            startDate: Date(),
            endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
            progress: 0.5,
            memo: "샘플 메모"
        )
        container.mainContext.insert(sampleGoal)
        
        return GoalListView(showWriteView: $showWriteView)
            .modelContainer(container)
    }
}
