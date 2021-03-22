//
//  Step.swift
//  JustWalking
//
//  Created by Jacob LeCoq on 3/21/21.
//

import Foundation

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}
