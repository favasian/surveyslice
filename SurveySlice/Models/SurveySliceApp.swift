//
//  SurveySlice.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/26/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit
import Foundation
import AdSupport

public protocol SurveySliceAppDelegate: class {
    func surveyCompleted(currencyPrizeAmount: Int, currency: String)
    func surveyDismissed()
}

public class SurveySliceApp {
    
    var api_key: String?
    var app_id: String?
    var idfa: String?
    var delegate: SurveySliceAppDelegate!
    var surveyee: Surveyee?
    
    public static var shared = Globals.app
    
    init() {
        self.setIDFA()
    }
    
    func tryToFetchAndSetSurveyee() {
        if let idfa = self.idfa {
            Surveyee.fetch(idfa: idfa, completionHandler: { [weak self] (surveyee) in
                self?.surveyee = surveyee
            })
        }
    }
    
    func setIDFA() {
        if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            self.idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        } else {
            self.idfa = nil
            Helper.logError("IDFA could not be obtained, Advertising Tracking may not be enabled")
        }
    }
    
    func surveyCompleted(currencyAmount: Int, currency: String) {
        self.delegate.surveyCompleted(currencyPrizeAmount: currencyAmount, currency: currency)
    }
    
    func didDismiss() {
        self.delegate.surveyDismissed()
    }
    
    //Public methods
    public func initWith(api_key: String, app_id: String) {
        self.api_key = api_key
        self.app_id = app_id
        self.tryToFetchAndSetSurveyee()
    }
    
    public func printIDFA(){
        self.setIDFA()
        guard let idfa = self.idfa else { return }
        Helper.logInfo("IDFA = \(idfa)")
    }
    
    public func display(delegate: SurveySliceAppDelegate) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate else {
            Helper.logError("Application Delegate does not exist")
            return false
        }
        guard let appVC = appDelegate.window??.rootViewController else {
            Helper.logError("Root View Controller does not exist")
            return false
        }
        guard let idfa = self.idfa else {
            Helper.logError("IDFA could not be obtained, Advertising Tracking may not be enabled")
            return false
        }
        guard let api_key = self.api_key else {
            Helper.logError("Api Key not set")
            return false
        }
        guard let app_id = self.app_id else {
            Helper.logError("App ID not set")
            return false
        }
       
        let ssvc = MainSurveySliceController.instantiate()
        self.delegate = delegate
        appVC.present(ssvc, animated: true, completion: nil)
        
        return true
    }
    
    
}
