//
//  GetInvestment.swift
//  SolidCrypto
//
//  Created by Jamal on 5/20/23.
//

import Foundation

struct Investment: Decodable {
    let id: Int64
    let tradeId: Int64
    let coinCode: String
    let status: String
    let entryVal: Double
    let winLimit: Double
    let loseLimit: Double
    let currentVal: Double
    let entryTime: String
    let terminationTime: String
    let history: [Double]
}

struct GetInvestment: Decodable {
    let investments: [Investment]
}
