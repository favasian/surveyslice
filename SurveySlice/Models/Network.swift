//
//  Network.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/26/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit
import Alamofire
import ReachabilitySwift
import Gloss


class Network: NSObject {
    let baseURL:String!
//    let headers: HTTPHeaders = [
//        "x-api-key": "aaYUMB0R9v1bZISg02duRaF6SFj2f5Xm7Y764YbG"
//    ]
    var session: URLSession!
    
    static let shared = Network()
    var reachability: Reachability!
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
            baseURL = "http://localhost:3000/api/v1"
        }
    }
    
    func setupReachability() {
        self.reachability = Reachability()!
        self.noInternetError = NSError(domain: "No Internet Available", code: 1, userInfo: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification,object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            self.internetAvailable = true
            print("could not start reachability notifier")
        }
    }

    @objc func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            self.internetAvailable = true
        } else {
            self.internetAvailable = false
            print("Network not reachable")
        }
    }
    
    func baseSurveyeeNetworkWrapper(completionHandler: @escaping ([JSON]?, NSError?) -> (), network: (String, String, String, @escaping ()->())->() ) {
        if self.internetAvailable && Globals.app.api_key != nil && Globals.app.devApp?.app_id != nil && Globals.app.surveyee?.idfa != nil{
            let bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
            network(Globals.app.api_key!, Globals.app.devApp!.app_id, Globals.app.surveyee!.idfa, {
                UIApplication.shared.endBackgroundTask(bgTask)
            })
        } else {
            completionHandler(nil, self.noInternetError)
        }
    }
    
    func baseSurveyeeNetworkWrapper(completionHandler: @escaping (JSON?, NSError?) -> (), network: (String, String, String, @escaping ()->())->() ) {
        if self.internetAvailable && Globals.app.api_key != nil && Globals.app.devApp?.app_id != nil && Globals.app.surveyee?.idfa != nil{
            let bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
            network(Globals.app.api_key!, Globals.app.devApp!.app_id, Globals.app.surveyee!.idfa, {
                UIApplication.shared.endBackgroundTask(bgTask)
            })
        } else {
            completionHandler(nil, self.noInternetError)
        }
    }
    
    func baseNetworkWrapper(completionHandler: @escaping (JSON?, NSError?) -> (), network: (String, String, @escaping ()->())->() ) {
        if self.internetAvailable && Globals.app.api_key != nil && Globals.app.devApp?.app_id != nil {
            let bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
            network(Globals.app.api_key!, Globals.app.devApp!.app_id, {
                UIApplication.shared.endBackgroundTask(bgTask)
            })
        } else {
            completionHandler(nil, self.noInternetError)
        }
    }
    
    func apiKeyOnlyNetworkWrapper(completionHandler: @escaping (JSON?, NSError?) -> (), network: (String, @escaping ()->())->() ) {
        if self.internetAvailable && Globals.app.api_key != nil {
            let bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
            network(Globals.app.api_key!, {
                UIApplication.shared.endBackgroundTask(bgTask)
            })
        } else {
            completionHandler(nil, self.noInternetError)
        }
    }
    
    func fetchSurveyee(idfa: String, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        self.baseNetworkWrapper(completionHandler: completionHandler) { (api_key, app_id, networkingFinished) in
            var acceptableCodes = [200, 404]
            Alamofire.request(self.baseURL + "/app/\(app_id)/surveyees/\(idfa)?api_key=" + api_key).validate(statusCode: acceptableCodes).responseJSON { response in
                switch response.result {
                case .success(let value):
                    Helper.logInfo("Successfully Fetched Surveyee Data")
                    if response.response?.statusCode == 404 {
                        completionHandler(nil, nil)
                    } else {
                        let dict = value as? [String:Any]
                        completionHandler(dict, nil)
                    }
                case .failure(let error):
                    Helper.logError("Failure Fetching Surveyee Data")
                    completionHandler(nil, error as NSError?)
                }
                networkingFinished()
            }
        }
    }
    
    func fetchApp(app_id: String, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        self.apiKeyOnlyNetworkWrapper(completionHandler: completionHandler) { (api_key, networkingFinished) in
            Alamofire.request(self.baseURL + "/app/\(app_id)?api_key=" + api_key).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    Helper.logInfo("Successfully Fetched App Data")
                    let dict = value as? [String: Any]
                    completionHandler(dict, nil)
                case .failure(let error):
                    Helper.logError("Failure Fetching App Data")
                    print(error)
                    completionHandler(nil, error as NSError?)
                }
                networkingFinished()
            }
        }
    }
    
    func createSurveyee(idfa: String, demographicParams: [String:Any], completionHandler: @escaping (JSON?, NSError?) -> ()) {
        print("demo param")
        print(demographicParams)
        let parameters:[String:Any] = ["idfa": idfa, "demographic_attributes": demographicParams]
         self.baseNetworkWrapper(completionHandler: completionHandler) { (api_key, app_id, networkingFinished) in
            Alamofire.request(self.baseURL + "/app/\(app_id)/surveyees?api_key=" + api_key, method: .post, parameters: parameters as? Parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    Helper.logInfo("Successfully Created Surveyee")
                    let dict = value as? [String: Any]
                    completionHandler(dict, nil)
                case .failure(let error):
                    Helper.logInfo("Failure Creating Surveyee")
                    completionHandler(nil, error as NSError?)
                }
                networkingFinished()
            }
        }
    }
    
    func fetchCampaigns(already_started: Bool, page: Int, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        self.baseSurveyeeNetworkWrapper(completionHandler: completionHandler) { (api_key, app_id, idfa, networkingFinished) in
            let url = self.baseURL + "/app/\(app_id)/surveyees/\(idfa)/campaigns"
            var params:[String:Any] = ["api_key": api_key, "page": page]
            if already_started { params["already_started"] = "true" }
            Alamofire.request(url, parameters: params).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    Helper.logInfo("Successfully Fetched Campaigns Data")
                    let dict = value as? JSON
                    completionHandler(dict, nil)
                case .failure(let error):
                    Helper.logError("Failure Fetching Campaigns Data")
                    print(error)
                    completionHandler(nil, error as NSError?)
                }
                networkingFinished()
            }
        }
    }
    
    func fetchSurvey(byCampaignId: Int, checkMinTime: Bool, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        self.baseSurveyeeNetworkWrapper(completionHandler: completionHandler) { (api_key, app_id, idfa, networkingFinished) in
            let url = self.baseURL + "/app/\(app_id)/surveyees/\(idfa)/surveys/\(byCampaignId)"
            var params:[String:Any] = ["api_key": api_key]
            if checkMinTime { params["check_min_time"] = "true" }
            Alamofire.request(url, parameters: params).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    Helper.logInfo("Successfully Fetched Survey Data")
                    let dict = value as? JSON
                    completionHandler(dict, nil)
                case .failure(let error):
                    Helper.logError("Failure Fetching Survey Data")
                    completionHandler(nil, error as NSError?)
                }
                networkingFinished()
            }
        }
    }
    
    func createPreSurveyUrlOpen(campaign: Campaign, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        self.createCampaignActivity(type: "pre_survey_url_opens", campaign: campaign, completionHandler: completionHandler)
    }
    
    func createInstall(campaign: Campaign, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        self.createCampaignActivity(type: "installs", campaign: campaign, completionHandler: completionHandler)
    }
    
    func createClick(campaign: Campaign, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        self.createCampaignActivity(type: "clicks", campaign: campaign, completionHandler: completionHandler)
    }
    
    func createImpression(campaign: Campaign, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        self.createCampaignActivity(type: "impressions", campaign: campaign, completionHandler: completionHandler)
    }
    
    func createSurveyStart(campaign: Campaign, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        self.createCampaignActivity(type: "survey_starts", campaign: campaign, completionHandler: completionHandler)
    }
    
    func createCompletion(campaign: Campaign, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        self.createCampaignActivity(type: "completions", campaign: campaign, completionHandler: completionHandler)
    }
    
    func createCampaignActivity(type: String, campaign: Campaign, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        self.baseSurveyeeNetworkWrapper(completionHandler: completionHandler) { (api_key, app_id, idfa, networkingFinished) in
            let url = self.baseURL +  "/app/\(app_id)/surveyees/\(idfa)/campaigns/\(campaign.id)/\(type)?api_key=" + api_key
            Alamofire.request(url, method: .post, encoding: JSONEncoding.default).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    Helper.logInfo("Successfully Created \(type)")
                    completionHandler(nil, nil)
                case .failure(let error):
                    Helper.logInfo("Failure Creating \(type)")
                    completionHandler(nil, error as NSError?)
                }
                networkingFinished()
            }
        }
    }
    
    func fetchQuestions(forSurveyId: Int, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        self.baseSurveyeeNetworkWrapper(completionHandler: completionHandler) { (api_key, app_id, idfa, networkingFinished) in
            let url = self.baseURL + "/app/\(app_id)/surveyees/\(idfa)/surveys/\(forSurveyId)/questions"
            let params:[String:Any] = ["api_key": api_key]
            Alamofire.request(url, parameters: params).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    Helper.logInfo("Successfully Fetched Questions Data")
                    let dict = value as? JSON
                    completionHandler(dict, nil)
                case .failure(let error):
                    Helper.logError("Failure Fetching Questions Data")
                    print(error)
                    completionHandler(nil, error as NSError?)
                }
                networkingFinished()
            }
        }
    }
    
    func createResponse(answerIds: [String], questionId: Int, surveyID: Int, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        self.baseSurveyeeNetworkWrapper(completionHandler: completionHandler) { (api_key, app_id, idfa, networkingFinished) in
            let url = self.baseURL +  "/app/\(app_id)/surveyees/\(idfa)/surveys/\(surveyID)/questions/\(questionId)/responses?api_key=" + api_key
            let params = ["answer_ids": answerIds]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    Helper.logInfo("Successfully Created Responses")
                    completionHandler(nil, nil)
                case .failure(let error):
                    Helper.logInfo("Failure Creating Responses")
                    completionHandler(nil, error as NSError?)
                }
                networkingFinished()
            }
        }
    }
}
