//
//  UnredeemedCompletionList.swift
//  SurveySlice
//
//  Created by Christopher Li on 6/25/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation
import Gloss

struct UnredeemedCompletionList: JSONDecodable {
    var unredeemed_completions: [UnredeemedCompletion]?
    
    init?(json: JSON) {
        self.unredeemed_completions = "entries"  <~~ json
    }
}
