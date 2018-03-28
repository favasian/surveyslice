//
//  Network.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/26/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit
import Alamofire
//import ReachabilitySwift

class Network: NSObject {
    let baseURL:String!
//    let headers: HTTPHeaders = [
//        "x-api-key": "aaYUMB0R9v1bZISg02duRaF6SFj2f5Xm7Y764YbG"
//    ]
    var session: URLSession!
    
    static let shared = Network()
    //var reachability: Reachability!
    var noInternetError: NSError!
    var internetAvailable = true
    
    override init() {
        #if DEBUG
            let __PRODUCTION = false
        #else
            let __PRODUCTION = true
        #endif
        session = URLSession.shared;
        if __PRODUCTION {
            baseURL = "https://survey-co.herokuapp.com/api/v1"
        } else {
            baseURL = "https://survey-co.herokuapp.com/api/v1"
        }
    }
    
//    func setupReachability() {
//        self.reachability = Reachability()!
//        self.noInternetError = NSError(domain: "No Internet Available", code: 1, userInfo: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification,object: reachability)
//        do{
//            try reachability.startNotifier()
//        }catch{
//            self.internetAvailable = true
//            print("could not start reachability notifier")
//        }
//    }
//
//    func reachabilityChanged(note: NSNotification) {
//        let reachability = note.object as! Reachability
//        if reachability.isReachable {
//            if reachability.isReachableViaWiFi {
//                print("Reachable via WiFi")
//            } else {
//                print("Reachable via Cellular")
//            }
//            self.internetAvailable = true
//        } else {
//            self.internetAvailable = false
//            print("Network not reachable")
//        }
//    }
    
    func networkWrapper(completionHandler: @escaping (NSDictionary?, NSError?) -> (), network: (String, String, @escaping ()->())->() ) {
        if self.internetAvailable && Globals.app.api_key != nil && Globals.app.app_id != nil {
            let bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
            network(Globals.app.api_key!, Globals.app.app_id!, {
                UIApplication.shared.endBackgroundTask(bgTask)
            })
        } else {
            completionHandler(nil, self.noInternetError)
        }
    }
    
    func fetchSurveyee(idfa: String, completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
        self.networkWrapper(completionHandler: completionHandler) { (api_key, app_id, networkingFinished) in
            var acceptableCodes = [200, 404]
            Alamofire.request(self.baseURL + "/app/\(app_id)/surveyees/\(idfa).json?api_key=" + api_key).validate(statusCode: acceptableCodes).responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("API fetchSurveyee: success")
                    if response.response?.statusCode == 404 {
                        completionHandler(nil, nil)
                    } else {
                        let dict = value as? NSDictionary
                        completionHandler(dict, nil)
                    }
                case .failure(let error):
                    print("API fetchSurveyee: failure fetchUser")
                    completionHandler(nil, error as NSError?)
                }
                networkingFinished()
            }
        }
    }
}
