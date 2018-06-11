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
    
    var id: Int
    var questionId: Int
    var answer: String
    var correct: Bool
    
    init?(json: JSON) {
        guard let id: Int = "id" <~~ json else { return nil }
        guard let questionId: Int = "question_id" <~~ json else { return nil }
        guard let answer: String = "answer" <~~ json else { return nil }
        guard let correct: Bool = "correct" <~~ json else { return nil }
        
        self.id = id
        self.questionId = questionId
        self.answer = answer
        self.correct = correct
    }
}
