//
//  Investment.swift
//  SolidCrypto
//
//  Created by Jamal on 5/20/23.
//

import Foundation

struct AddInvestment: Decodable {
    
    let investmentId: Int
    let tradeId: Int
    let coinCode: String
    let amount: Double
    let status: String
    let entryVal: Double
    let winLimit: Double
    let loseLimit: Double
    let currentVal: Double
    let entryTime: String
    let terminationTime: String
    let resultDiff: Double
    var description: String {
        return "Investment with entry value: \(entryVal), wining limit: \(winLimit) and lose limit: \(loseLimit) is \(status)."
    }
}
