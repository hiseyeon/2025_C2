//
//  TopTrashView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/18/25.
//

import SwiftUI

struct TopTrashView: View {
    
    @Binding var isSelecting: Bool
    
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                Text("휴지통")
                    .padding()
                    .font(.system(size: 20, weight: .bold))
                
                
                HStack{
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            isSelecting.toggle()
                        }
                    }) {
                        Text(isSelecting ? "취소" : "선택")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.pink)
                            .padding(.trailing)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                
            }
            Divider()
        }
        
        
    }
}


#Preview {
    TopTrashPreviewWrapper()
}

private struct TopTrashPreviewWrapper: View {
    @State private var selecting = false
    
    var body: some View {
        TopTrashView(isSelecting: $selecting)
    }
}
