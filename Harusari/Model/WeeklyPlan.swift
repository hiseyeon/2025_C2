//
//  WeeklyPlan.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/21/25.
//

import Foundation
import SwiftData

@Model
class WeeklyPlan: Identifiable {
    var week: Int
    var content: String
    var isChecked: Bool
    var goal: Goal?

    init(week: Int, content: String = "", isChecked: Bool = false, goal: Goal? = nil) {
        self.week = week
        self.content = content
        self.isChecked = isChecked
        self.goal = goal
    }
}
