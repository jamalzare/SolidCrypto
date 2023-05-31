//
//  GetTrades.swift
//  SolidCrypto
//
//  Created by Jamal on 5/20/23.
//

import Foundation

struct Trade: Decodable {
    let tradeId: Int
    let name: String
    let upper: Double
    let lower: Double
    let margin: Double
    
    var displayName: String {
        return "\(name) \(tradeId)"
    }
}

struct GetTrades: Decodable {
    let trades: [Trade]
}
