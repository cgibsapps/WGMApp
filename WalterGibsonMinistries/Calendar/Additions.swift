//
//  Additions.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/8/21.
//

import Foundation
import SwiftUI


let colorAssortment: [Color] = [.turquoise, .forestGreen, .darkPink, .darkRed, .lightBlue, .salmon, .military]

extension Color {

    static var randomColor: Color {
        let randomNumber = arc4random_uniform(UInt32(colorAssortment.count))
        return colorAssortment[Int(randomNumber)]
    }

}

extension Color {

    static let turquoise = Color(red: 24, green: 147, blue: 120)
    static let forestGreen = Color(red: 22, green: 128, blue: 83)
    static let darkPink = Color(red: 179, green: 102, blue: 159)
    static let darkRed = Color(red: 185, green: 22, blue: 77)
    static let lightBlue = Color(red: 72, green: 147, blue: 175)
    static let salmon = Color(red: 219, green: 135, blue: 41)
    static let military = Color(red: 117, green: 142, blue: 41)
    static let placeholderGray = Color(red: 0, green: 0, blue: 0.0980392, opacity: 0.22)

}

extension Color {

    init(red: Int, green: Int, blue: Int) {
        self.init(red: Double(red)/255, green: Double(green)/255, blue: Double(blue)/255)
    }

}

extension Date {

    static func daysFromToday(_ days: Int) -> Date {
        Date().addingTimeInterval(TimeInterval(60*60*24*days))
    }

}

extension DateComponents {

    static var everyDay: DateComponents {
        DateComponents(hour: 0, minute: 0, second: 0)
    }

}

extension Date {

    var fullDate: String {
        DateFormatter.fullDate.string(from: self)
    }
    
    var partialDate: String {
        DateFormatter.partialDate.string(from: self)
    }

    var timeOnlyWithPadding: String {
        DateFormatter.timeOnlyWithPadding.string(from: self)
    }

}


extension DateFormatter {

    static var fullDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter
    }
    
    static var partialDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }

    static let timeOnlyWithPadding: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()

}

struct LightDarkThemePreview<Preview: View>: View {

    let preview: Preview

    var body: some View {
        Group {
            LightThemePreview {
                self.preview
            }

            DarkThemePreview {
                self.preview
            }
        }
    }

    init(@ViewBuilder preview: @escaping () -> Preview) {
        self.preview = preview()
    }

}

struct LightThemePreview<Preview: View>: View {

    let preview: Preview

    var body: some View {
        preview
            .previewLayout(.sizeThatFits)
            .colorScheme(.light)
    }

    init(@ViewBuilder preview: @escaping () -> Preview) {
        self.preview = preview()
    }

}

struct DarkThemePreview<Preview: View>: View {

    let preview: Preview

    var body: some View {
        preview
            .previewLayout(.sizeThatFits)
            .colorScheme(.dark)
            .background(Color.black.edgesIgnoringSafeArea(.all))
    }

    init(@ViewBuilder preview: @escaping () -> Preview) {
        self.preview = preview()
    }

}


extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}


extension UIColor {
    
    static let flatDarkBackground = UIColor(red: 245, green: 245, blue: 245)
    static let flatDarkCardBackground = UIColor(red: 240, green: 240, blue: 240)
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
}

extension Color {
    public init(decimalRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
    
    public static var flatDarkBackground: Color {
        return Color(decimalRed: 245, green: 245, blue: 245)
    }
    
    public static var flatDarkCardBackground: Color {
        return Color(decimalRed: 240, green: 240, blue: 240)
    }
}


