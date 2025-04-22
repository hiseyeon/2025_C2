//
//  TopDetailView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/19/25.
//

import SwiftUI

struct TopDetailView: View {
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                Text("상세보기")
                    .padding()
                    .font(.system(size: 20, weight: .bold))
                
                
                HStack{
                    Spacer()
                    
                    Text("수정")
                        .padding(.trailing, 16)
                    
                }
                
            }
            Divider()
            
        }
    }
}
    
    
    #Preview {
        TopDetailView()
    }
