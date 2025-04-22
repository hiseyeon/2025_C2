//
//  ContentWriteView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/16/25.
//

import SwiftUI

struct ContentWriteView: View {
    
    @Binding var memo: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("메모")
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 8)
            
            ZStack(alignment: .topLeading) {
                if memo.isEmpty {
                    Text("메모 입력해주라")
//                        .font(.system(size: 16))
                        .foregroundColor(.gray2)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 28)
                }
                
                TextEditor(text: $memo)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 18)
                    .frame(minHeight: 164)
                    .scrollContentBackground(.hidden) // 이게 무슨 역할인데
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray2, lineWidth: 1)
                    )
            }
        }
    }
}

#Preview {
    ContentWritePreviewHost()
}

private struct ContentWritePreviewHost: View {
    @State private var memo = ""
    
    var body: some View {
        ContentWriteView(memo: $memo)
    }
}
