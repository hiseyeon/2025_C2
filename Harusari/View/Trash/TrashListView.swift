//
//  TrashListView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/14/25.
//

// MARK: - 휴지통 page

import SwiftUI
import SwiftData

struct TrashListView: View {
    
    @Binding var isSelecting: Bool
    @Binding var selectedGoals: Set<Goal>
    
    @Query(filter: #Predicate<Goal> { $0.isTrashed }) var goals: [Goal]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack (spacing: 0){
            TopTrashView(isSelecting: $isSelecting)
            
            if goals.isEmpty {
                GoalEmptyView()
                    .padding(.top, 50)
            } else {
                List {
                    ForEach(goals) { goal in
                        if isSelecting {
                            TrashEditSelectableView(
                                goal: goal,
                                isSelecting: isSelecting,
                                isSelected: selectedGoals.contains(goal),
                                onSelect: {
                                    if selectedGoals.contains(goal) {
                                        selectedGoals.remove(goal)
                                    } else {
                                        selectedGoals.insert(goal)
                                    }
                                }
                            )
                        } else {
                            TrashCardView(goal: goal)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            
            
            // ✅ 하단 액션 버튼 (선택 시만 표시)
//            if isSelecting {
//                BottomActionView(
//                    restoreAction: {
//                        for goal in selectedGoals {
//                            goal.isTrashed = false
//                        }
//                        selectedGoals.removeAll()
//                        isSelecting = false
//                    },
//                    deleteAction: {
//                        for goal in selectedGoals {
//                            context.delete(goal)
//                        }
//                        selectedGoals.removeAll()
//                        isSelecting = false
//                    }
//                )
//                //                .transition(.move(edge: .bottom))
//            }
        }
    }
}

//#Preview {
//    TrashListView()
//}

