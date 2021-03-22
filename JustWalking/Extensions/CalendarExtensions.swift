//
//  CalendarExtensions.swift
//  JustWalking
//
//  Created by Jacob LeCoq on 3/21/21.
//

import Foundation

extension Calendar {
    static var sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
}
