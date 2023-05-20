//
//  APIService.swift
//  PayCore
//
//  Created by Jamal on 8/11/22.
//

import Foundation

class APIService {
    
    static var loggingEnabled = true
    
    static func loadProfessions(completion: @escaping (Coin?, APIResponseError?) -> ()) {
        let req = APIRequest<Coin>(route: "api/core/v1/professions",
                                            method: .get,
                                            parameters: nil)
        
        req.identifier = "Professions"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func initilizeRegister(gsm: String, completion: @escaping (Coin?, APIResponseError?) -> () ) {
        
        let params = [
            "phoneNumberCountryCode": "90",
            "phoneNumber": "gsm",
        ]
        
        let req = APIRequest<Coin>(route: "api/core/v1/customers/registration/initialize",
                                                 method: .post,
                                                 parameters: params)
        req.identifier = "initilizeRegister"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
}
