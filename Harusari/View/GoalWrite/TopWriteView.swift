//
//  TopWriteView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/16/25.
//

import SwiftUI

struct TopWriteView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var dismissAction: () -> Void
    
    var body: some View {
        
        VStack(spacing: 0){
            ZStack{
                Text("목표 작성하기")
                    .padding()
                    .font(.system(size: 20, weight: .bold))
                
                
                HStack{
                    Spacer()
                    
                    Button(action: dismissAction) {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.pink)
                            .font(.system(size: 20))
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
    TopWriteView(dismissAction: { print("닫기") })
}
