//
//  QuestionsList.swift
//  SurveySlice
//
//  Created by Christopher Li on 4/6/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation
import Gloss

struct QuestionList: JSONDecodable {
    var questions: [Question]?
    
    init?(json: JSON) {
        self.questions = "entries"  <~~ json
    }
}
