//
//  Surveyee.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/26/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation

class Surveyee {
    
    var idfa: String
    
    init(surveyeeData: NSDictionary) {
        guard let idfa = surveyeeData.value(forKey: "idfa") as? String else { fatalError("Surveyee no IDFA") }
        self.idfa = idfa
    }
    
    
    class func fetch(idfa: String, completionHandler: @escaping (Surveyee?) -> ()) {
        Network.shared.fetchSurveyee(idfa: idfa) { (surveyeeData, error) in
            if let _ = error {
                completionHandler(nil)
            } else {
                guard let surveyeeData = surveyeeData else {
                    completionHandler(nil)
                    return
                }
                let surveyee = Surveyee(surveyeeData: surveyeeData)
                completionHandler(surveyee)
            }
        }
    }
    
    class func createFromInitialProfilerAnswers(_ submittedAnswers: [[String]], completion: @escaping (Surveyee?)->()) {
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
                let surveyee = Surveyee(surveyeeData: surveyeeData)
                completion(surveyee)
            }
        }
    }
}
