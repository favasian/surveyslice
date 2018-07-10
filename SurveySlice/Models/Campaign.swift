//
//  Campaign.swift
//  SurveySlice
//
//  Created by Christopher Li on 4/5/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation
import Gloss

struct Campaign: JSONDecodable {
    
    var id: Int
    var bid: Double?
    var avgCompletionTime: Int?
    var externalLink: String?

    init?(json: JSON) {
        guard let id: Int = "id" <~~ json else { return nil }
        guard let bidString: NSString = "bid" <~~ json else { return nil }
        
        self.id = id
        self.bid = bidString.doubleValue
        self.avgCompletionTime = "avg_completion_time" <~~ json
        self.externalLink = "external_link" <~~ json
        if let el = self.externalLink {
            if let rup = Globals.app.reward_url_param {
                self.externalLink = "\(el)&reward_url_param=\(rup)"
            }
        }
    }
    
    func awardAmount() -> Int {
        guard let bid = self.bid else { return 0 }
        guard let devApp = Globals.app.devApp else { return 0 }
        let amount = bid * devApp.revenueShare * Double(devApp.currencyAmountPerDollar)
        return Int(amount)
    }

    static func fetch(already_started: Bool, page: Int, completionHandler: @escaping (CampaignList?) -> ()) {
        Network.shared.fetchCampaigns(already_started: already_started, page: page) { (campaignsData, error) in
            if let campaignsData = campaignsData {
                let campaignList = CampaignList(json: campaignsData)
                completionHandler(campaignList)
            } else {
                completionHandler(nil)
            }
        }
    }
    
}

