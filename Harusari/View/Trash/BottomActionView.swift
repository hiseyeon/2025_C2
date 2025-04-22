//
//  BottomActionView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/15/25.
//

import SwiftUI

struct BottomActionView: View {
    
    var restoreAction: () -> Void = {}
    var deleteAction: () -> Void = {}
    
    var body: some View {
        VStack{
            
            Divider()
            
        HStack(spacing: 0) {
            Button(action: restoreAction) {
                Text("복구")
                    .font(.title3)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                    .frame(height: 70)
                //                                .background(Color.white)
                //                                .contentShape(Rectangle())
            }
            Divider()
                .frame(height: 70)
            //            .overlay(
            //                Rectangle()
            //                    .frame(width: 1)
            //                    .foregroundColor(Color.gray.opacity(0.3)),
            //                alignment: .trailing
            //            )
            
            Button(action: deleteAction) {
                Text("삭제")
                    .font(.title3)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .frame(height: 70)
                //                                .background(Color.white)
                //                                                .contentShape(Rectangle())
            }
        }
        .background(Color.white)
        //                            .clipShape(RoundedRectangle(cornerRadius: 0))
        //                            .shadow(color: .gray.opacity(0.2), radius: 2, y: -2)
    }
}
}

#Preview {
    BottomActionView()
}
