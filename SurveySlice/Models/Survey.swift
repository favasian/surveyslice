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
    var campaignId: Int
    var questionCount: Int
    
    var preSurveyUrl: String?
    var preSurveyUrlName: String?
    var preSurveyAppStoreId: String?
    var visitedUrlMinimumMinutes: Int?
    var specialNote: String?
    
    
    var preSurveyApp: PreSurveyApp?
    
    init?(json: JSON) {
        print(json)
        guard let campaignId: Int = "campaign_id" <~~ json else { return nil }
        guard let id: Int = "id" <~~ json else { return nil }
        guard let questionCount: Int = "question_count" <~~ json else { return nil }
        
        self.id = id
        self.campaignId = campaignId
        self.questionCount = questionCount
        
        self.preSurveyUrl = "pre_survey_url" <~~ json
        self.preSurveyUrlName = "pre_survey_url_name" <~~ json
        self.preSurveyAppStoreId = "pre_survey_app_store_id" <~~ json
        self.visitedUrlMinimumMinutes = "visited_url_minimum_minutes" <~~ json
        self.specialNote = "special_note" <~~ json
        self.preSurveyApp = "pre_survey_app" <~~ json
    }
    
    static func fetch(byCampaignId: Int, completionHandler: @escaping (Survey?) -> ()) {
        Network.shared.fetchSurvey(byCampaignId: byCampaignId) { (surveyData, error) in
            if let surveyData = surveyData {
                let survey = Survey(json: surveyData)
                completionHandler(survey)
            } else {
                completionHandler(nil)
            }
        }
    }
}

