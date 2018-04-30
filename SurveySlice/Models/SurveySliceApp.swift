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
    var idfa: String?
    var app_id: String?
    var delegate: SurveySliceAppDelegate!
    
    var devApp: DevApp?
    var surveyee: Surveyee?
    
    public static var shared = Globals.app
    
    init() {
        self.setIDFA()
    }
    
    func fetchAndSetVars(app_id: String, completion: (()->())?=nil ) {
        self.fetchAndSetApp(app_id: app_id) { [weak self] in
            self?.fetchAndSetSurveyee(completion: {
                completion?()
            })
            
        }
    }
    
    func fetchAndSetSurveyee(completion: (()->())?=nil) {
        if let idfa = self.idfa {
            Surveyee.fetch(idfa: idfa, completionHandler: { [weak self] (surveyee) in
                self?.surveyee = surveyee
                completion?()
            })
        }
    }
    
    func fetchAndSetApp(app_id: String, completion: @escaping () -> ()) {
        DevApp.fetch(app_id: app_id, completionHandler: { [weak self] (devApp) in
            if let devApp = devApp {
                self?.devApp = devApp
                completion()
            } else {
                Helper.logError("App with id (\(app_id)) does not exist")
            }
        })
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
        self.fetchAndSetVars(app_id: app_id)
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
        guard let devApp = self.devApp else {
            if let app_id = self.app_id {
                self.fetchAndSetVars(app_id: app_id) // try to set it again
            }
            Helper.logError("App with supplied ID does not exist")
            return false
        }
       
        let ssvc = MainSurveySliceController.instantiate()
        self.delegate = delegate
        appVC.present(ssvc, animated: true, completion: nil)
        
        return true
    }
    
    
}
