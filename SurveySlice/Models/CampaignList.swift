//
//  CampaignList.swift
//  SurveySlice
//
//  Created by Christopher Li on 4/6/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//


import Foundation
import Gloss

struct CampaignList: JSONDecodable {
    var nextPage: Int?
    var campaigns: [Campaign]?
    
    init?(json: JSON) {
        self.nextPage = "next_page" <~~ json
        self.campaigns = "entries"  <~~ json
    }
}
