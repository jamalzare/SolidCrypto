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
    var entryTime: String
    let terminationTime: String
    let resultDiff: Double
    let succeeded: Bool
    let finished: Bool
    
    var displayDate: String {
        
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let time = String(entryTime.dropLast(7))
        if let date = formmater.date(from: time) {
            formmater.dateFormat = "yyyy/MM/dd HH:mm:ss"
            return formmater.string(from: date)
        }
        
        return ""
    }
    
    var duration: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let time = String(entryTime.dropLast(7))
        if let date = formmater.date(from: time) {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            let relativeDate = formatter.localizedString(for: date, relativeTo: Date())
            return relativeDate
        }

        return ""
    }
    
    var state: String {
        if !finished {
            return "ONGOING"
        }
        
        if succeeded {
            return "SUCCEEDED"
        }
        if !succeeded {
            return "FAILED"
        }
        
        if finished {
            return "FREE"
        }
        return "Unknown"
    }
    
    var description: String {
        return "Investment with entry value: \(entryVal), success state is \(succeeded) and finish state is \(finished)."
    }
    
}
