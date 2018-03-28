//
//  DevApp.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/28/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation

class DevApp {
    
    var app_id: String
    var name: String
    var currency: String
    var currencyAmountPerDollar: Int
    var icon: String
    var status: String
    
    init(appData: NSDictionary) {
        guard let app_id = appData.value(forKey: "app_id") as? String else { fatalError("DevApp no app_id") }
        guard let name = appData.value(forKey: "name") as? String else { fatalError("DevApp no name") }
        guard let currency = appData.value(forKey: "currency") as? String else { fatalError("DevApp no currency") }
        guard let currencyAmountPerDollar = appData.value(forKey: "currency_amount_per_dollar") as? Int else { fatalError("DevApp no currency_amount_per_dollar") }
        guard let icon = appData.value(forKey: "icon") as? String else { fatalError("DevApp no icon") }
        guard let status = appData.value(forKey: "status") as? String else { fatalError("DevApp no status") }
        
        self.app_id = app_id
        self.name = name
        self.currency = currency
        self.currencyAmountPerDollar = currencyAmountPerDollar
        self.icon = icon
        self.status = status
    }
    
    
    class func fetch(app_id: String, completionHandler: @escaping (DevApp?) -> ()) {
        Network.shared.fetchApp(app_id: app_id) { (appData, error) in
            if let _ = error {
                print(error)
                completionHandler(nil)
            } else {
                guard let appData = appData else {
                    completionHandler(nil)
                    return
                }
                let devApp = DevApp(appData: appData)
                completionHandler(devApp)
            }
        }
    }
}
