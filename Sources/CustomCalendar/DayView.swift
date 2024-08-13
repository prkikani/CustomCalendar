//
//  DayView.swift
//  Demo
//
//  Created by Pradip Kikani on 12/08/24.
//

import SwiftUI

// DayView
struct DayView: View {
    var date: Date
    var isSelected: Bool
    var isInRange: Bool
    var themeColor: Color

    private var dayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    var body: some View {
        Text(dayText)
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(isSelected ? themeColor.opacity(0.6) : isInRange ? themeColor.opacity(0.2) : Color.clear)
            .clipShape(Circle())
            .foregroundColor(isSelected ? .white : .primary)
    }
}

// Date Extensions
extension Date {
    func startOfMonth(using calendar: Calendar) -> Date {
        return calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
    }

    func daysInMonth(using calendar: Calendar) -> Int {
        let range = calendar.range(of: .day, in: .month, for: self)!
        return range.count
    }
}
