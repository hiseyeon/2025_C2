//
//  MainTabView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/15/25.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    
    @State private var selectedTab = 0
    @State private var showWriteView = false
    @State private var isSelecting = false
    @State private var selectedGoals: Set<Goal> = []
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    TabView(selection: $selectedTab) {
                        GoalListView(showWriteView: $showWriteView)
                            .tabItem {
                                Label("목록", systemImage: "text.justify")
                            }
                            .tag(0)
                        
                        Color.clear
                            .tabItem {
                                Label("추가", systemImage: "plus")
                            }
                            .tag(1)
                        
                        TrashListView(
                            isSelecting: $isSelecting,
                            selectedGoals: $selectedGoals
                        )
                        .tabItem {
                            Label("휴지통", systemImage: "trash")
                        }
                        .tag(2)
                    }
                    //                    .opacity(isSelecting ? 0 : 1) // 전체 TabView 숨기기
                }
                
                if isSelecting {
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 83)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .transition(.opacity)
                    
                    BottomActionView(
                        restoreAction: {
                            for goal in selectedGoals {
                                goal.isTrashed = false
                            }
                            selectedGoals.removeAll()
                            isSelecting = false
                        },
                        deleteAction: {
                            for goal in selectedGoals {
                                context.delete(goal)
                            }
                            selectedGoals.removeAll()
                            isSelecting = false
                        }
                    )
                }
            }
            .animation(.easeInOut, value: isSelecting)
            .accentColor(.pink2)
            .onChange(of: selectedTab) {
                if selectedTab == 1 {
                    showWriteView = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        selectedTab = 0
                    }
                    
                }
            }
            .fullScreenCover(isPresented: $showWriteView) {
                GoalWriteView(isPresented: $showWriteView)
            }
//            .sheet(isPresented: $showWriteView) {
//                GoalWriteView(isPresented: $showWriteView)
//            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Goal.self, configurations: config)

        // ✅ 샘플 데이터
        let sampleGoal = Goal(
            title: "프리뷰 목표",
            startDate: Date(),
            endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
            progress: 0.5,
            memo: "프리뷰용 메모"
        )
        container.mainContext.insert(sampleGoal)

        return MainTabView()
            .modelContainer(container)
    } catch {
        return Text("⚠️ 프리뷰 실패: \(error.localizedDescription)")
    }
}
