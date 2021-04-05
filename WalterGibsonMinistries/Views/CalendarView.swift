//
//  CalendarView.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/7/21.
//

import SwiftUI

import ElegantCalendar


let date = Calendar.current.date(from: DateComponents(hour: 0, minute: 0))
let startDate = Date().addingTimeInterval(Date().timeIntervalSinceNow)
let endDate = Date().addingTimeInterval(TimeInterval(31536000.0))

class SelectionModel: ObservableObject {
    @State var selectedDate: Date?
    @Published var showCalendar = false
    @Published var monthlyCalendarManager = MonthlyCalendarManager(configuration: CalendarConfiguration(startDate: Date().addingTimeInterval(Date().timeIntervalSinceNow), endDate: Date().addingTimeInterval(TimeInterval(31536000.0))), initialMonth: Date().addingTimeInterval(Date().timeIntervalSinceNow))

    
    
}

extension SelectionModel: MonthlyCalendarDelegate {

    func calendar(didSelectDay date: Date) {
        self.selectedDate = date
        self.showCalendar = false
    }

}

struct NewCalendarView: View {
    @ObservedObject var model: SelectionModel = .init()
    
    var monthlyCalendarManager: MonthlyCalendarManager {
        model.monthlyCalendarManager
    }
    var monthlyCalendar: some View {
        MonthlyCalendarView(calendarManager: monthlyCalendarManager)
    }
    
    var body: some View {
        monthlyCalendar
    }
    
}

struct NewCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        NewCalendarView()
    }
}


extension SelectionModel: MonthlyCalendarDataSource {
    func calendar(canSelectDate date: Date) -> Bool {
        return ((monthlyCalendarManager.datasource?.calendar(canSelectDate: date)) != nil)
    }
    
    private func calendar(viewForSelectedDate date: Date, dimensions size: CGSize) -> CalendarForm {
        return CalendarForm(date: formatter.string(from: date))
    }
}

let formatter = DateFormatter()

struct CalendarForm: View {
    var date: String
    var body: some View {
        VStack {
            Text(date)
        }
    }
}

struct CalendarView: View {

    // Start & End date should be configured based on your needs.
    var components = DateComponents(hour: 8, minute: 0)
    let date = Calendar.current.date(from: DateComponents(hour: 0, minute: 0))
    
    let startDate = Date().addingTimeInterval(Date().timeIntervalSinceNow)
    let endDate = Date().addingTimeInterval(TimeInterval(31536000.0))

    @State var selectedDate: Date?
    
    @ObservedObject var monthlyCalendar = MonthlyCalendarManager(configuration: CalendarConfiguration(startDate: Date().addingTimeInterval(Date().timeIntervalSinceNow), endDate: Date().addingTimeInterval(TimeInterval(31536000.0))), initialMonth: Date().addingTimeInterval(Date().timeIntervalSinceNow))
    @ObservedObject var calendarManager = ElegantCalendarManager(configuration: CalendarConfiguration(startDate: Date().addingTimeInterval(Date().timeIntervalSinceNow), endDate: Date().addingTimeInterval(TimeInterval(31536000.0))))

    var monthlyCalendarM: MonthlyCalendarView = .init(calendarManager: MonthlyCalendarManager(configuration: CalendarConfiguration(startDate: Date().addingTimeInterval(Date().timeIntervalSinceNow), endDate: Date().addingTimeInterval(TimeInterval(31536000.0))), initialMonth: Date().addingTimeInterval(Date().timeIntervalSinceNow)))
    
    var body: some View {
        VStack {
            ElegantCalendarView(calendarManager: calendarManager)
                .theme(.craftBrown)
                .allowsHaptics(true)
            MonthlyCalendarView(calendarManager: monthlyCalendar)
                .theme(.craftBrown)
                .allowsHaptics(true)
        }
        
    }

}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

