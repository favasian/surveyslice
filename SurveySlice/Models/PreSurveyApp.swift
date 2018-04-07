//
//  PreSurveyApp.swift
//  SurveySlice
//
//  Created by Christopher Li on 4/6/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation
import Gloss

struct PreSurveyApp: JSONDecodable {
    
    var name: String?
    var logo: String?
    var developer: String?
    var stars: Int?
    
    init?(json: JSON) {
        self.name = "name" <~~ json
        self.developer = "developer" <~~ json
        self.logo = "logo" <~~ json
        self.stars = "stars" <~~ json
    }
}
