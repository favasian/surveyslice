//
//  Surveyee.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/26/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation
import Gloss

struct Surveyee: JSONDecodable {
    
    var idfa: String
    
    init?(json: JSON) {
        guard let idfa: String = "idfa" <~~ json else { return nil }
        self.idfa = idfa
    }
    
    static func fetch(idfa: String, completionHandler: @escaping (Surveyee?) -> ()) {
        Network.shared.fetchSurveyee(idfa: idfa) { (surveyeeData, error) in
            if let surveyeeData = surveyeeData {
                let surveyee = Surveyee(json: surveyeeData)
                completionHandler(surveyee)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    static func createFromInitialProfilerAnswers(_ submittedAnswers: [[String]], completion: @escaping (Surveyee?)->()) {
        guard let idfa = Globals.app.idfa else { fatalError("Surveyee no IDFA") }
        let demographicParams = Demographic.initialProfileAnswersToApiHash(answers: submittedAnswers)
        Network.shared.createSurveyee(idfa: idfa, demographicParams: demographicParams) { (surveyeeData, error) in
            if let _ = error {
                completion(nil)
            } else {
                guard let surveyeeData = surveyeeData else {
                    completion(nil)
                    return
                }
                let surveyee = Surveyee(json: surveyeeData)
                completion(surveyee)
            }
        }
    }
}
