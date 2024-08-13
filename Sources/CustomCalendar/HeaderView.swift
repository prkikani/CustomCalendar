//
//  HeaderView.swift
//  Demo
//
//  Created by Pradip Kikani on 12/08/24.
//

import SwiftUI
struct HeaderView: View {
    @Binding var currentDate: Date
    var calendar: Calendar
    var themeColor: Color
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }

    var body: some View {
        HStack {
            Button(action: {
                self.currentDate = self.previousMonth()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(themeColor)
            }
            Spacer()
            Text(dateFormatter.string(from: currentDate))
                .font(.headline)
                .foregroundColor(themeColor)
            Spacer()
            Button(action: {
                self.currentDate = self.nextMonth()
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(themeColor)
            }
        }
        .padding()
    }

    private func previousMonth() -> Date {
        guard let newDate = calendar.date(byAdding: .month, value: -1, to: currentDate) else {
            return currentDate
        }
        return newDate
    }

    private func nextMonth() -> Date {
        guard let newDate = calendar.date(byAdding: .month, value: 1, to: currentDate) else {
            return currentDate
        }
        return newDate
    }
}
