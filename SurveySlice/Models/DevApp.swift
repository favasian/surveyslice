//
//  DevApp.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/28/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation
import Gloss

struct DevApp: JSONDecodable {
    
    var app_id: String
    var name: String
    var currency: String
    var currencyAmountPerDollar: Int
    var icon: String
    var status: String
    var revenueShare: Double
    
    init?(json: JSON) {
        print(json)
        guard let app_id: String = "app_id" <~~ json else { return nil }
        guard let name: String = "name" <~~ json else { return nil }
        guard let currency: String = "currency" <~~ json else { return nil }
        guard let currencyAmountPerDollar: Int = "currency_amount_per_dollar" <~~ json else { return nil }
        guard let icon: String = "icon" <~~ json else { return nil }
        guard let status: String = "status" <~~ json else { return nil }
        guard let revenueShare: NSString = "revenue_share" <~~ json else { return nil }
        
        self.app_id = app_id
        self.name = name
        self.currency = currency
        self.currencyAmountPerDollar = currencyAmountPerDollar
        self.icon = icon
        self.status = status
        self.revenueShare = revenueShare.doubleValue
    }

    static func fetch(app_id: String, completionHandler: @escaping (DevApp?) -> ()) {
        Network.shared.fetchApp(app_id: app_id) { (appData, error) in
            if let appData = appData {
                let devApp = DevApp(json: appData)
                completionHandler(devApp)
            } else {
                completionHandler(nil)
            }
        }
    }
}
