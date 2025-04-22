//
//  Goal.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/15/25.
//

import Foundation
import SwiftData

@Model
class Goal: Equatable, Hashable {
    var title: String
    var startDate: Date
    var endDate: Date
    var progress: Double
    var isTrashed: Bool = false
    var memo: String?
    var weeklyPlans: [WeeklyPlan] = []
    
    init(title: String, startDate: Date, endDate: Date, progress: Double, isTrashed: Bool = false, memo: String, weeklyPlans: [WeeklyPlan] = []) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.progress = progress
        self.isTrashed = isTrashed
        self.memo = memo
        self.weeklyPlans = weeklyPlans
    }

 
    static func == (lhs: Goal, rhs: Goal) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
