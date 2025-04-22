//
//  GoalDetailToolbar.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/22/25.
//

import SwiftUI

struct GoalDetailToolbar: View {

    @Binding var isEditing: Bool
    
    var body: some View {
        ZStack {
            Text("상세보기")
                .font(.headline)

            HStack {
                Spacer()
                Button(action: {
                    isEditing.toggle()
                }) {
                    Text(isEditing ? "완료" : "편집")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
//        HStack{
//            Text("상세보기")
//                .font(.headline)
////                .frame(maxWidth: .infinity, alignment: .center)
//
////            Spacer(minLength: 16)
//            
//            Button(action: {
//                isEditing.toggle()
//            }){
//                Text(isEditing ? "완료" : "편집")
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//            }
//        }
//        .frame(maxWidth: .infinity)
//    }
}


#Preview {
    GoalDetailToolbar(isEditing: .constant(false))
}

