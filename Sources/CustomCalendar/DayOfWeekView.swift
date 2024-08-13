//
//  DayOfWeekView.swift
//  Demo
//
//  Created by Pradip Kikani on 12/08/24.
//

import SwiftUI

struct DaysOfWeekView: View {
    var themeColor: Color
    var calendar: Calendar

    private var daysOfWeek: [String] {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        return formatter.shortWeekdaySymbols
    }

    var body: some View {
        HStack {
            ForEach(daysOfWeek, id: \.self) { day in
                Text(day)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(themeColor)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
