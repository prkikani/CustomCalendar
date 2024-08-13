//
//  MonthView.swift
//  Demo
//
//  Created by Pradip Kikani on 12/08/24.
//

import SwiftUI

struct MonthView: View {
    @Binding var selectedStartDate: Date
    @Binding var selectedEndDate: Date?
    var isRangeSelection:Bool
    var calendar: Calendar
    var themeColor: Color

    private var monthStartDate: Date {
        selectedStartDate.startOfMonth(using: calendar)
    }

    private var daysInMonth: Int {
        selectedStartDate.daysInMonth(using: calendar)
    }

    private var startDayOffset: Int {
        calendar.component(.weekday, from: monthStartDate) - calendar.firstWeekday
    }

    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(0..<daysInMonth + startDayOffset, id: \.self) { index in
                    if index < startDayOffset {
                        Text("").frame(maxWidth: .infinity, minHeight: 40)
                    } else {
                        let day = index - startDayOffset + 1
                        let dayDate = calendar.date(byAdding: .day, value: day - 1, to: monthStartDate)!
                        
                        DayView(
                            date: dayDate,
                            isSelected:isRangeSelection ? isSelected(dayDate) : calendar.isDate(dayDate, inSameDayAs: selectedStartDate),
                            isInRange: isInRange(dayDate),
                            themeColor: themeColor
                        )
                        .onTapGesture {
                            if isRangeSelection {
                                handleDateSelection(for: dayDate)
                            }
                            else {
                                selectedStartDate = dayDate
                            }
                            
                        }
                    }
                }
            }
        }
        .padding()
    }

    private func handleDateSelection(for date: Date) {
        if selectedEndDate == nil {
            if calendar.isDate(date, inSameDayAs: selectedStartDate) {
                selectedStartDate = Date()
            } else if date > selectedStartDate {
                selectedEndDate = date
            } else {
                selectedStartDate = date
                selectedEndDate = nil
            }
        } else {
            selectedStartDate = date
            selectedEndDate = nil
        }
        
    }

    private func isSelected(_ date: Date) -> Bool {
        if let end = selectedEndDate {
            return calendar.isDate(date, inSameDayAs: selectedStartDate) || calendar.isDate(date, inSameDayAs: end)
        } else {
            return calendar.isDate(date, inSameDayAs: selectedStartDate)
        }
    }

    private func isInRange(_ date: Date) -> Bool {
        if let end = selectedEndDate {
            return date > selectedStartDate && date < end
        }
        return false
    }
}
