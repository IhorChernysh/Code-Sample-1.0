//
//  Date+Ext.swift
//  p153-ios
//
//  Created by ihor-ios on 27.05.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

enum DateFormat: String {
    case hours = "HH"
    case minutes = "mm"
    case hourMinutes = "HH:mm"
    case dayMonthYearDot = "dd.MM.yyyy"
    case dayMonthYearSpace = "dd MMMM yyyy"
    case isoFormat = "yyyy-MM-dd HH:mm:ss"
    case isoWithoutHours = "yyyy-MM-dd"
    case monthlongYear = "LLLL yyyy"
    case daynameDayMonthYear = "E, d MMM yyyy"
    case monthStringDayYear = "MMMM d, yyyy"
    case monthDayYear = "MMM d, yyyy"
    case shortMonthName = "LLL"
    case monthNameAndDay = "MMMM d"
    case month = "MMMM"
    case shortMonth = "MM"
    case shortDayName = "EEE"
    case dayName = "EEEE"
    case day = "dd"
    case year = "yyyy"
    case monthYear = "MM yyyy"
    case yearMonth = "yyyy-MM"
}

extension Date {
    func convertToFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_De")
        formatter.dateFormat = format
        let dateString = formatter.string(from: self)
        return dateString
    }
}
