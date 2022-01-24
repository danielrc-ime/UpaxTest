//
//  DataModel.swift
//  UpaxTest
//
//  Created by Daniel iOS on 21/01/22.
//

import Foundation

// MARK: - DataModel
struct DataModel: Codable {
    let colors: [String]
    let questions: [Question]
}

// MARK: - Question
struct Question: Codable {
    let total: Int
    let text: String
    let chartData: [ChartDatum]
}

// MARK: - ChartDatum
struct ChartDatum: Codable {
    let text: String
    let percetnage: Int
}

