//
//  Question.swift
//  SurveySlice
//
//  Created by Christopher Li on 4/6/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation
import Gloss

struct Question: JSONDecodable {
    
    var id: Int
    var surveyId: Int
    var question: String
    var multiSelect: Bool
    var answers: [Answer]?
    
    init?(json: JSON) {
        guard let id: Int = "id" <~~ json else { return nil }
        guard let surveyId: Int = "survey_id" <~~ json else { return nil }
        guard let question: String = "question" <~~ json else { return nil }
        guard let multiSelect: Bool = "multi_select" <~~ json else { return nil }
        
        
        self.id = id
        self.surveyId = surveyId
        self.question = question
        self.multiSelect = multiSelect
        
        self.answers = "answers" <~~ json
    }
    
    static func fetch(forSurvey: Survey, completionHandler: @escaping ([Question]?) -> ()) {
        Network.shared.fetchQuestions(forSurveyId: forSurvey.id) { (questionsData, error) in
            print("data")
            print(questionsData)
            if let questionsData = questionsData {
                let questionList = QuestionList(json: questionsData)
                print("list")
                print(questionList)
                completionHandler(questionList?.questions)
            } else {
                completionHandler(nil)
            }

        }
    }
}
