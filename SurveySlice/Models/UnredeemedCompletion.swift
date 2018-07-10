//
//  UnredeemedCompletion.swift
//  SurveySlice
//
//  Created by Christopher Li on 6/25/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation
import Gloss

struct UnredeemedCompletion: JSONDecodable {
    
    var id: Int
    var revenue: Double?
    
    init?(json: JSON) {
        guard let id: Int = "id" <~~ json else { return nil }
        guard let revenueString: NSString = "revenue" <~~ json else { return nil }

        self.id = id
        self.revenue = revenueString.doubleValue
    }
    
    func awardAmount() -> Int {
        guard let revenue = self.revenue else { return 0 }
        guard let devApp = Globals.app.devApp else { return 0 }
        let amount = revenue * Double(devApp.currencyAmountPerDollar)
        return Int(amount)
    }
    
    func redeem(completionHandler: @escaping (Bool) -> ()) {
        Network.shared.redeemUnredeemedCompletions(completion_id: self.id) { (data, error) in
            if let _ = error {
                completionHandler(false)
            } else {
                completionHandler(true)
            }
        }
    }
}
