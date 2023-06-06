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
        return "\(name)"
    }
    
    var lose: Double? {
        var words = name.components(separatedBy: " ")
        if words.count > 1 {
            words[1].removeFirst()
            let value = Double(words[1])
            return value
        }
        return nil
    }
    
    var win: Double? {
        var words = name.components(separatedBy: " ")
        if words.count > 3 {
            words[3].removeFirst()
            let value = Double(words[3])
            return value
        }
        return nil
    }
    
}

struct GetTrades: Decodable {
    let trades: [Trade]
}
