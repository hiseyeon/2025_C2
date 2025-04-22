//
//  GoalWriteView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/14/25.
//

// MARK: - 목표 작성 page

import SwiftUI

struct StatefulPreviewWrapper<Value>: View {
    @State private var value: Value
    var content: (Binding<Value>) -> AnyView
    
    init(_ initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> some View) {
        _value = State(initialValue: initialValue)
        self.content = { binding in AnyView(content(binding)) }
    }
    
    var body: some View {
        content($value)
    }
}

struct GoalWriteView: View {
    
    @Binding var isPresented: Bool
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var date = Date()
    @State var title: String = ""
    @State var memo: String = ""
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    
    @State private var selectedStartDate = Date()
    @State private var selectedEndDate = Date()
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // Top
            TopWriteView(dismissAction: {
                isPresented = false
            })
            
            VStack {
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        
                        TitleWriteView(title: $title)
                            .padding(.bottom, 28)
                        
                        DatePickerView(startDate: $selectedStartDate, endDate: $selectedEndDate)
                            .padding(.bottom, 28)
                        
                        ContentWriteView(memo: $memo)
                            .padding(.bottom, 28)
                        
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                    
                }
                
                //                Spacer()
            }
            
            Button(action: {
                let newGoal = Goal(
                    title: title,
                    startDate: selectedStartDate,
                    endDate: selectedEndDate,
                    progress: 0.0,
                    isTrashed: false,
                    memo: memo.isEmpty ? " " : memo
                )
                context.insert(newGoal)
                isPresented = false     // 작성 뷰 닫기
                print("저장된 목표: \(newGoal.title)")
            }) {
                Text("등록하기")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(title.isEmpty ? Color.gray2 : Color.black)
            }
            .disabled(title.isEmpty)
        }
        .ignoresSafeArea(edges: .bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .onTapGesture {
            hideKeyboard()
        }
        
        
    }
    
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

#Preview {
    StatefulPreviewWrapper(true) { binding in
        GoalWriteView(isPresented: binding)
    }
}
