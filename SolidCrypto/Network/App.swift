//
//  App.swift
//  SolidCrypto
//
//  Created by Jamal on 5/20/23.
//

import Foundation
import UIKit

class App {
    
    static var appLoaded = false {
        didSet {
//            if appLoaded, let url = deepLinkURL {
//                appCoordinator?.loadDeepLink(url: url)
//                deepLinkURL = nil
//            }
        }
    }
    
    static var deviceId: String {
//        guard let id = Persistence.deviceId else {
//            let deviceId = UUID().uuidString
//            Persistence.deviceId = deviceId
//            return deviceId
//        }
//        return id
        return "id"
    }
    
//    static var appLanguage: String {
//        guard let lan = Persistence.appLanguage else {
//            return initialzeAppLanguage()
//        }
//        return lan
//    }
    
//    static func initialzeAppLanguage() -> String {
//        let lang = Locale.preferredLanguages.first ?? ""
//        let ln = lang.contains(CodeStrings.tr) ? CodeStrings.trTr: CodeStrings.enUS
//        Persistence.appLanguage = ln
//        return ln
//    }
    
    static func netIsReachable(_ reachable: Bool) {
//        Loading.shared.message = reachable ? "": Strings.checkInternetConnection
    }
    
//    static func refreshToken<T: Decodable>(request: APIRequest<T>) {
//
//        APIService.refreshToken { model, error in
//
//            if let _ = model {
//                request.setToken()
//                request.start()
//            }
//            else if let error = error {
//                print(error)
//                appCoordinator?.restart()
//            }
//        }
//    }
    
//    static func restart() {
//        appCoordinator?.restart()
//    }
    
}

//MARK: Handle DeepLink
extension App {
    
    static func handleDeepLink(url: URL) -> Bool {
//        deepLinkURL = url
        
        if appLoaded {
//            appCoordinator?.loadDeepLink(url: url)
//            deepLinkURL = nil
        }
        return true
    }
    
}
