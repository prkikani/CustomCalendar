//
//  CalenderView.swift
//  Demo
//
//  Created by Pradip Kikani on 12/08/24.
//

import SwiftUI

public struct CustomCalendar: View {
    @State private var selectedStartDate: Date = Date()
    @State private var selectedEndDate: Date?

    public let themeColor: Color
    public let calendar: Calendar
    public let isRangeSelection: Bool
    public let headerbackGround: Color
    public let onDone: (Date?, Date?) -> Void // Closure for done action
    public let onCancel: () -> Void // Closure for cancel action

    public init(
        selectedStartDate: Date = Date(),
        selectedEndDate: Date? = nil,
        themeColor: Color = .pink,
        isRangeSelection: Bool,
        calendar: Calendar = .current,
        headerbackGround: Color = Color.pink.opacity(0.1),
        onDone: @escaping (Date?, Date?) -> Void, // Initialize done action
        onCancel: @escaping () -> Void // Initialize cancel action
    ) {
        self.selectedStartDate = selectedStartDate
        self.selectedEndDate = selectedEndDate
        self.themeColor = themeColor
        self.calendar = calendar
        self.headerbackGround = headerbackGround
        self.onDone = onDone
        self.onCancel = onCancel
        self.isRangeSelection = isRangeSelection
    }

    public var body: some View {
        VStack {
            HeaderView(currentDate: $selectedStartDate, calendar: calendar, themeColor: themeColor).background(headerbackGround)
            DaysOfWeekView(themeColor: themeColor, calendar: calendar)
            MonthView(
                selectedStartDate: $selectedStartDate,
                selectedEndDate: $selectedEndDate,
                isRangeSelection: isRangeSelection,
                calendar: calendar,
                themeColor: themeColor
            )
            .padding()

            HStack {
                Button(action: {
                    onCancel()
                }) {
                    Text("Cancel")
                        .foregroundColor(themeColor)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Button(action: {
                    onDone(selectedStartDate, selectedEndDate)
                }) {
                    Text("Done")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(themeColor)
                        .cornerRadius(8)
                }
            }
            .padding(.top)
        }
        .padding()
    }
}


// MonthView
/*struct MonthView: View {
    @Binding var selectedDate: Date
    var calendar: Calendar
    var themeColor: Color

    private var monthStartDate: Date {
        selectedDate.startOfMonth(using: calendar)
    }

    private var daysInMonth: Int {
        selectedDate.daysInMonth(using: calendar)
    }

    private var startDayOffset: Int {
        calendar.component(.weekday, from: monthStartDate) - calendar.firstWeekday
    }

    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(0..<daysInMonth + startDayOffset, id: \.self) { index in
                    if index < startDayOffset {
                        Text("")
                            .frame(maxWidth: .infinity, minHeight: 40)
                    } else {
                        let day = index - startDayOffset + 1
                        let dayDate = calendar.date(byAdding: .day, value: day - 1, to: monthStartDate)!

                        DayView(
                            date: dayDate,
                            isSelected: calendar.isDate(dayDate, inSameDayAs: selectedDate),
                            themeColor: themeColor
                        )
                        .onTapGesture {
                            selectedDate = dayDate
                        }
                    }
                }
            }
        }
        .padding()
    }
}*/

//

//struct ContentView1: View {
//    var body: some View {
//        CustomCalendar(isRangeSelection: false,
//            onDone: { startDate, endDate in
//                if let start = startDate, let end = endDate {
//                    print("Selected range is from \(start) to \(end)")
//                } else if let start = startDate {
//                    print("Selected start date is \(start)")
//                } else {
//                    print("No date selected")
//                }
//            },
//            onCancel: {
//                print("Selection canceled")
//                // Perform actions when "Cancel" is pressed, such as resetting the selection
//            }
//        )
//    }
//}
//
//#Preview {
//    ContentView1()
//}
