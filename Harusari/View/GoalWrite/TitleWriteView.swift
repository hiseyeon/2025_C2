//
//  TitleWriteView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/16/25.
//

import SwiftUI

struct TitleWriteView: View {
    
    @Binding var title: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("제목")
                .padding(.bottom, 8)
                .font(.system(size: 20, weight: .semibold))
            
            ZStack(alignment: .leading) {
                if title.isEmpty {
                    Text("제목 입력해주라")
                        .foregroundColor(.gray2)
                        .padding(.horizontal, 24)
                        .padding(.vertical)
                }
                
                TextEditor(text: $title)
                    .padding(.horizontal, 20)
                    .padding(.vertical)
                    .frame(height: 52)
                    .scrollContentBackground(.hidden)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray2, lineWidth: 1)
                    )
                    .focused($isFocused)
            }
        }
    }
}
//#Preview {
//    TitleWriteView()
//}
