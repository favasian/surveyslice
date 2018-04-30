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
    var visitedUrlMinimumMinutesExpiration: Int?
    
    
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
        self.visitedUrlMinimumMinutesExpiration = "visited_url_minimum_minutes_expiration" <~~ json
    }
    
    static func fetch(byCampaignId: Int, checkMinTime: Bool, completionHandler: @escaping (Survey?) -> ()) {
        Network.shared.fetchSurvey(byCampaignId: byCampaignId, checkMinTime: checkMinTime) { (surveyData, error) in
            if let surveyData = surveyData {
                let survey = Survey(json: surveyData)
                completionHandler(survey)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func errorStringVisitedUrlMinimumMinutes(timeLeft: Int) -> String {
        let minutes = timeLeft/60 + 1
        var minLeftString = ""
        if minutes == 1 {
            minLeftString = "minute"
        } else {
            minLeftString = "\(minutes) minutes"
        }
        
        guard let url = self.preSurveyUrl else { return "" }
        guard let appId = self.preSurveyAppStoreId else {
            guard let urlName = self.preSurveyUrlName, urlName != "" else {
                return "You must visit and browse the site for another \(minLeftString) before taking the survey"
            }
            return "You must visit and browse \(urlName) for another \(minLeftString) before taking the survey"
        }
        if let appName = self.preSurveyUrlName, appName != "" {
            return "You must download and use \(appName) for another \(minLeftString) before taking the survey"
        }
        guard let appName = self.preSurveyApp?.name, appName != "" else {
            return "You must download and use the app for another \(minLeftString) before taking the survey"
        }
        return "You must download and use \(appName) for another \(minLeftString) before taking the survey"
    }
}

