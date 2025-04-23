//
//  DatePickerView.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/16/25.
//

import SwiftUI

struct DatePickerView: View {
    
    @Binding var startDate: Date
    @Binding var endDate: Date

    @State private var activePicker: ActiveDatePicker? = nil
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("기간")
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 8)
            
            VStack(spacing: 0) {
                            dateRow(label: "시작", date: startDate) {
                                withAnimation {
                                    activePicker = (activePicker == .start) ? nil : .start
                                }
                            }
                            Divider()
                                .frame(height: 1)
                                .background(Color.gray2)
                            
                            dateRow(label: "종료", date: endDate) {
                                withAnimation {
                                    activePicker = (activePicker == .end) ? nil : .end
                                }
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray2, lineWidth: 1)
                        )
                        
                        if activePicker == .start {
                            DatePicker("", selection: $startDate, displayedComponents: [.date])
                                .datePickerStyle(.graphical)
//                                .datePickerStyle(.compact)
//                                .padding(.vertical)
                        }

                        if activePicker == .end {
                            DatePicker("", selection: $endDate, displayedComponents: [.date])
                                .datePickerStyle(.graphical)
//                                .datePickerStyle(.compact)
                                .padding(.vertical)
                                .onChange(of: endDate) {
                                    if endDate < startDate {
                                        endDate = startDate
                                    }
                                }
                        }
                    }
                    .padding(.vertical)
                
//                    .padding()
                }
                
                func dateRow(label: String, date: Date, action: @escaping () -> Void) -> some View {
                    Button(action: action) {
                        HStack {
                            Text(label)
                                .foregroundColor(.gray)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(formattedDate(date))
                                .foregroundColor(.pink2)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.gray1)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                    }
                }
                
                func formattedDate(_ date: Date) -> String {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy. M. d."
                    return formatter.string(from: date)
                }
                
                enum ActiveDatePicker {
                    case start, end
                }
            }

//            #Preview {
//                DatePickerView()
//            }
