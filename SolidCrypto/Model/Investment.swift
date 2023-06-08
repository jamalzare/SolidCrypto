//
//  Investment.swift
//  SolidCrypto
//
//  Created by Jamal on 5/20/23.
//

import Foundation
import UIKit

enum TradeState: String {
    
    case ongoing = "ONGOING"
    case succeded = "SUCCEEDED"
    case failed = "FAILED"
    case free = "FREE"
}

struct AddInvestment: Decodable {
    
    let investmentId: Int
    let tradeId: Int
    let coinCode: String
    let amount: Int
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
            let f = date.addingTimeInterval(3*60*60)
            formmater.dateFormat = "dd.MM.yyyy HH:mm:ss"
            return formmater.string(from: f)
        }
        
        return ""
    }
    
    var duration: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let time = String(entryTime.dropLast(7))
        if let date = formmater.date(from: time) {
            let f = date.addingTimeInterval(3*60*60)
            return f.relativeDateAsString()
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
    
    var tradeState: TradeState {
        
        if !finished {
            return .ongoing
        }
        
        if succeeded && finished {
            return .succeded
        }
        if !succeeded && finished {
            return .failed
        }
        
        return .free
    }
    
    var tradeStateColor: UIColor {
        
        switch tradeState {
        case .ongoing:
            return .appBlue
            
        case .succeded:
            return .theme
            
        case .failed:
            return .appPink
            
        case .free:
            return .appBlackText
        }
    }
    
    var currentProgressValue: Double {
        return Double(amount) * ((currentVal / entryVal) - 1) * 100
    }
    
    var progress: Double {
        if currentVal == entryVal {
            return 0.5
            
        } else if currentVal > entryVal {
            return 0.5 + ((currentVal - entryVal) / (winLimit - entryVal) * 0.5)
            
        } else {
            var f = 0.5 - ((entryVal - currentVal) / (entryVal - loseLimit) * 0.5)
            if f < 0 {
                f = f * -1
            }
            
            return f
        }
    }
}
