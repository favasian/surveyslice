//
//  Survey.swift
//  SurveySlice
//
//  Created by Christopher Li on 4/5/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation
import Gloss

struct Survey: JSONDecodable {
    
    var id: Int
    var campaign_id: Int
    
    init?(json: JSON) {
        guard let campaign_id: Int = "campaign_id" <~~ json else { return nil }
        guard let id: Int = "id" <~~ json else { return nil }
        
        self.id = id
        self.campaign_id = campaign_id
    }
    
}

