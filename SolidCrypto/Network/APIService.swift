//
//  APIService.swift
//  PayCore
//
//  Created by Jamal on 8/11/22.
//

import Foundation

class APIService {
    
    static var loggingEnabled = true
    
    static func login(username: String, password: String, completion: @escaping (Login?, APIResponseError?) -> () ) {
        
        let params = [
            "username": username,
            "password": password,
        ]
        
        let req = APIRequest<Login>(route: "login",
                                    method: .post,
                                    parameters: params)
        req.identifier = "login"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getBalance(completion: @escaping (Balance?, APIResponseError?) -> ()) {
        let req = APIRequest<Balance>(route: "balance",
                                   method: .get,
                                   parameters: nil)
        
        req.identifier = "balance"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getCoins(completion: @escaping ([String]?, APIResponseError?) -> ()) {
        let req = APIRequest<[String]>(route: "coins",
                                   method: .get,
                                   parameters: nil)
        
        req.identifier = "coins"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getTrades(coinCode: String, completion: @escaping ([Trade]?, APIResponseError?) -> ()) {
        let req = APIRequest<[Trade]>(route: "trade/\(coinCode)",
                                   method: .get,
                                   parameters: nil)
        
        req.identifier = "trades"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func addInvestment(coinCode: String, amount: Double, tradeId: Int, completion: @escaping (AddInvestment?, APIResponseError?) -> () ) {
        
        let params = [
            "coin": coinCode,
            "amount": amount,
            "tradeId": tradeId
        ] as [String : Any]
        
        let req = APIRequest<AddInvestment>(route: "invest",
                                   method: .post,
                                   parameters: params)
        req.identifier = "investments"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getInvestments(completion: @escaping (GetInvestment?, APIResponseError?) -> ()) {
        let req = APIRequest<GetInvestment>(route: "investments",
                                   method: .get,
                                   parameters: nil)
        
        req.identifier = "investments"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
}
