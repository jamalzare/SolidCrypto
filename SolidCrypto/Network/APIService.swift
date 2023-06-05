//
//  APIService.swift
//  PayCore
//
//  Created by Jamal on 8/11/22.
//

import Foundation

class APIService {
    
    static var loggingEnabled = false
    
    static func signup(username: String, password: String, completion: @escaping (Login?, APIResponseError?) -> () ) {
        
        let params = [
            "email": username,
            "password": password,
        ]
        
        let req = APIRequest<Login>(route: "sign-up",
                                    method: .post,
                                    parameters: params)
        req.identifier = "sign-up"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func login(username: String, password: String, completion: @escaping (Login?, APIResponseError?) -> () ) {
        
        let params = [
            "email": username,
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
    
    static func getBalance(completion: @escaping (Double?, APIResponseError?) -> ()) {
        let req = APIRequest<Double>(route: "balance",
                                      method: .get,
                                      parameters: nil,
                                      hasToken: true)
        
        req.identifier = "balance"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getCoins(completion: @escaping ([String]?, APIResponseError?) -> ()) {
        let req = APIRequest<[String]>(route: "coins",
                                       method: .get,
                                       parameters: nil,
                                       hasToken: true)
        
        req.identifier = "coins"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getTrades(coinCode: String, completion: @escaping ([Trade]?, APIResponseError?) -> ()) {
        let req = APIRequest<[Trade]>(route: "trade/\(coinCode)",
                                      method: .get,
                                      parameters: nil,
                                      hasToken: true)
        
        req.identifier = "trades"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func addInvestment(slot: String, coinCode: String, amount: Double, tradeId: Int, completion: @escaping (AddInvestment?, APIResponseError?) -> () ) {
        
        let params = [
            "slot": slot,
            "coin": coinCode,
            "amount": amount,
            "tradeId": tradeId
        ] as [String : Any]
        
        let req = APIRequest<AddInvestment>(route: "invest",
                                            method: .post,
                                            parameters: params,
                                            hasToken: true)
        req.identifier = "investments"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getInvestmentStatus(investmentId: Int, completion: @escaping (AddInvestment?, APIResponseError?) -> ()) {
        let req = APIRequest<AddInvestment>(route: "status/\(investmentId)",
                                            method: .get,
                                            parameters: nil,
                                            hasToken: true)
        
        req.identifier = "status"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getInvestments(completion: @escaping (GetInvestment?, APIResponseError?) -> ()) {
        let req = APIRequest<GetInvestment>(route: "investments",
                                            method: .get,
                                            parameters: nil,
                                            hasToken: true)
        
        req.identifier = "investments"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func deleteInvestments(slot: String, completion: @escaping (GetInvestment?, APIResponseError?) -> ()) {
        let req = APIRequest<GetInvestment>(route: "invest?slot=\(slot)",
                                            method: .delete,
                                            parameters: nil,
                                            hasToken: true)
        
        req.identifier = "delete investments"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func me(completion: @escaping (Me?, APIResponseError?) -> ()) {
        let req = APIRequest<Me>(route: "me",
                                 method: .get,
                                 parameters: nil,
                                 hasToken: true)
        
        req.identifier = "me"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getStatistics(coin: String, completion: @escaping ([Double]?, APIResponseError?) -> ()) {
        let req = APIRequest<[Double]>(route: "\(coin)",
                                       method: .get,
                                       parameters: nil,
                                       baseUrl: "http://54.75.26.59:8080/history/")
        req.identifier = "coins"
        req.log = false
        req.completion = completion
        req.start()
    }
    
}
