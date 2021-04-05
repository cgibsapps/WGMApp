//
//  Request.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/8/21.
//

import Foundation
import SwiftUI
import ElegantCalendar




class Request {

    let locationName: String
    let tagColor: Color
    let arrivalDate: Date
    let departureDate: Date

    var duration: String {
        arrivalDate.timeOnlyWithPadding + " ➝ " + departureDate.timeOnlyWithPadding
    }
    
    init(locationName: String, tagColor: Color, arrivalDate: Date, departureDate: Date) {
        self.locationName = locationName
        self.tagColor = tagColor
        self.arrivalDate = arrivalDate
        self.departureDate = departureDate
    }

}

extension Request: Identifiable {

    var id: Int {
        UUID().hashValue
    }

}

extension Request {

    static func mock(withDate date: Date) -> Request {
        Request(locationName: "Apple Inc",
              tagColor: .randomColor,
              arrivalDate: date,
              departureDate: date.addingTimeInterval(60*60))
    }

    static func mocks(start: Date, end: Date) -> [Request] {
        currentCalendar.generateRequests(
            start: start,
            end: end)
    }


}

class NewRequest {

    var name: String = "Open Time"
    let tagColor: Color
    let startDate: Date
    let endDate: Date
    var description: String = ""
    var open = true
    
    init(name: String, tagColor: Color, startDate: Date, endDate: Date, description: String, open: Bool) {
        self.name = name
        self.tagColor = tagColor
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
        self.open = open
        dateDict[startDate] = 0
    }
    
    init(tagColor: Color, startDate: Date, endDate: Date) {
        self.tagColor = tagColor
        self.startDate = startDate
        self.endDate = endDate
    }

}

extension NewRequest: Identifiable {

    var id: Int {
        UUID().hashValue
    }

}

extension NewRequest {

    static func add(name: String, startDate: Date, endDate: Date, description: String) -> NewRequest {
        NewRequest(name: name, tagColor: .gray, startDate: startDate, endDate: endDate, description: description, open: false)
    }

    static func adds(start: Date, end: Date) -> [NewRequest] {
        currentCalendar.generateRequests(
            start: start,
            end: end)
    }
    
    static func open(start: Date) -> NewRequest {
        NewRequest(tagColor: .lightBlue, startDate: start, endDate: start)
    }

}

fileprivate let requestCountRange = 1...20

private extension Calendar {

    func generateRequests(start: Date, end: Date) -> [Request] {
        var requests = [Request]()

        enumerateDates(
            startingAfter: start,
            matching: .everyDay,
            matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date < end {
                    for _ in 0..<Int.random(in: requestCountRange) {
                        requests.append(.mock(withDate: date))
                    }
                } else {
                    stop = true
                }
            }
        }

        return requests
    }
    
    func generateRequests(start: Date, end: Date) -> [NewRequest] {
        var requests = [NewRequest]()
        requests.append(NewRequest.add(name: "Christina Korzen", startDate: Date(), endDate: Date(), description: ""))
        requests.append(NewRequest.add(name: "Christian Gibson", startDate: Date.tomorrow, endDate: Date.tomorrow, description: ""))
        requests.append(NewRequest.add(name: "Cameron Gibson", startDate: Date().addingTimeInterval(86400*3), endDate: Date().addingTimeInterval(86400*3), description: ""))

        enumerateDates(
            startingAfter: start,
            matching: .everyDay,
            matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date < end {
                    //for _ in 0..<Int.random(in: requestCountRange) {
                        requests.append(.open(start: date))
                    //}
                } else {
                    stop = true
                }
            }
        }
        
        return requests
    }

}
