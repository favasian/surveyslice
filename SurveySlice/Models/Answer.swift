//
//  AnswerOption.swift
//  SurveySlice
//
//  Created by Christopher Li on 4/6/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation
import Gloss

struct Answer: JSONDecodable {
    
    var questionId: Int
    var answer: String
    
    init?(json: JSON) {
        guard let questionId: Int = "question_id" <~~ json else { return nil }
        guard let answer: String = "answer" <~~ json else { return nil }
        
        self.questionId = questionId
        self.answer = answer
    }
}
