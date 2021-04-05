//
//  RequestView.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/8/21.
//

import ElegantCalendar
import SwiftUI

let currentCalendar = Calendar.current
let screen = UIScreen.main.bounds

struct RequestCalendarView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject private var calendarManager: ElegantCalendarManager

    let requestsByDay: [Date: [NewRequest]]

    @State private var calendarTheme: CalendarTheme = .royalBlue

    init(ascRequests: [NewRequest], initialMonth: Date?) {
        let configuration = CalendarConfiguration(
            calendar: currentCalendar,
            startDate: ascRequests.first!.startDate,
            endDate: ascRequests.last!.startDate)

        calendarManager = ElegantCalendarManager(
            configuration: configuration,
            initialMonth: initialMonth)

        requestsByDay = Dictionary(
            grouping: ascRequests,
            by: { currentCalendar.startOfDay(for: $0.startDate) })

        calendarManager.datasource = self
        calendarManager.delegate = self
    }

    var body: some View {
        ZStack {
            ElegantCalendarView(calendarManager: calendarManager)
                .theme(calendarTheme)
//            VStack {
//                Spacer()
//                changeThemeButton
//                    .padding(.bottom, 50)
//            }
            VStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Exit Bookings")
                        .font(.headline)
                        .frame(width: 160)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                })
                .background(
                    Capsule()
                        .fill(calendarTheme.primary)
                )
                .padding(.bottom, 50)
            }
            
        }
    }

//    private var changeThemeButton: some View {
//        ChangeThemeButton(calendarTheme: $calendarTheme)
//    }
    
}

extension RequestCalendarView: ElegantCalendarDataSource {

    func calendar(backgroundColorOpacityForDate date: Date) -> Double {
        let startOfDay = currentCalendar.startOfDay(for: date)
        return Double((requestsByDay[startOfDay]?.count ?? 0) + 3) / 15.0
    }

//    func calendar(canSelectDate date: Date) -> Bool {
//        let day = currentCalendar.dateComponents([.day], from: date).day!
//        return day != 4
//    }
    
    func calendar(canSelectDate date: Date) -> Bool {
        //let day = currentCalendar.dateComponents([.day], from: date).day!
        
        let value = dateDict[date]
        return value != 0
    }

    func calendar(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView {
        //let startOfDay = currentCalendar.startOfDay(for: date)
        return RequestButton(selectedDate: date).erased
        
    }
    
}


extension RequestCalendarView: ElegantCalendarDelegate {

    func calendar(didSelectDay date: Date) {
        //print("Selected date: \(date)")
    }

    func calendar(willDisplayMonth date: Date) {
        //print("Month displayed: \(date)")
    }

    func calendar(didSelectMonth date: Date) {
        //print("Selected month: \(date)")
    }

    func calendar(willDisplayYear date: Date) {
        //print("Year displayed: \(date)")
    }

}

struct RequestCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        RequestCalendarView(ascRequests: NewRequest.adds(start: Date(), end: Date().advanced(by: 86400*365)), initialMonth: nil)
    }
}

func datesRange(from: Date, to: Date) -> [Date] {
    // in case of the "from" date is more than "to" date,
    // it should returns an empty array:
    if from > to { return [Date]() }

    var tempDate = from
    var array = [tempDate]

    while tempDate < to {
        tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
        array.append(tempDate)
    }

    return array
}

func makeDateDict() -> [Date:Int] {
    let dates = datesRange(from: Date(), to: Date().advanced(by: 86400*365))
    
    var dateDict: [Date:Int] = [:]
    for date in dates {
        dateDict[date] = 1
    }
    return dateDict
}

var dateDict = makeDateDict()


