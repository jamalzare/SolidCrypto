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
    let entryVal: Double
    let winLimit: Double
    let loseLimit: Double
    let currentVal: Double
    let entryTime: String
    let terminationTime: String
    let resultDiff: Double
    let succeeded: Bool
    let finished: Bool
    
    var description: String {
        return "Investment with entry value: \(entryVal), success state is \(succeeded) and finish state is \(finished)."
    }
    
}
