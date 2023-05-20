//
//  GetTrades.swift
//  SolidCrypto
//
//  Created by Jamal on 5/20/23.
//

import Foundation

struct Trade: Decodable {
    let id: Int
    let name: String
}

struct GetTrades: Decodable {
    let trades: [Trade]
}
