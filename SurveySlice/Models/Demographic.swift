//
//  Demographic.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/28/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation

class Demographic {
    
    
    class func initialProfileAnswersToApiHash(answers: [[String]]) -> [String:Any] {
        var hash:[String:Any] = [:]
        var index = 0
        for qa in Demographic.intialProfilerQAs() {
            let isDemographic = qa["isDemographic"] as! Bool
            if isDemographic {
                let key = qa["demographicKey"] as! String
                if let backend_value_options = qa["backend_value_options"] as? [String] {
                    let options = qa["options"] as! [String]
                    var backendAnswers:[String] = []
                    for answer in answers[index] {
                        if let answerIndex = options.index(of: answer) {
                            backendAnswers.append(backend_value_options[answerIndex])
                        }
                    }
                    hash[key] = backendAnswers
                } else {
                    hash[key] = answers[index]
                }
            }
           
            index += 1
        }
        return hash
    }
    
    class func intialProfilerQAs() -> [[String:Any]] {
        return [
            [
                "question": "Please select your gender.",
                "options": [],
                "multi": false,
                "type": QuestionType.gender,
                "isDemographic": true,
                "demographicKey": "gender"
            ],
            [
                "question": "What is your age?",
                "options": [],
                "multi": false,
                "type": QuestionType.number,
                "isDemographic": true,
                "demographicKey": "age"
            ],
            [
                "question": "Take the number between 3 and 5. What is this number minus 2?",
                "options": ["1", "2", "3", "4", "5"],
                "multi": false,
                "type": QuestionType.multipleChoice,
                "correctAnswers": ["2"],
                "isDemographic": false
            ],
            [
                "question": "How many hours a week do you spend playing games on your phone?",
                "options": ["0-3 hours", "4-7 hours", "8-13 hours", "14-19 hours", "20+ hours"],
                "backend_value_options": ["0-3", "4-7", "8-13", "14-19", "20+"],
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "gaming_hpw"
            ],
            [
                "question": "How much would you estimate you spend on in-app purchases each year?",
                "options": ["Nothing", "$1.00-$5.00", "$5.01-$15.00", "$15.01-$35.00", "$35.01-$50.00", "$50.01-$75.00", "Over $75.00", "Prefer not to answer"],
                "backend_value_options": ["Nothing", "$1.00-$5.00", "$5.01-$15.00", "$15.01-$35.00", "$35.01-$50.00", "$50.01-$75.00", "Over $75.00", "Prefer not to answer"],
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "iap_spy"
            ],
            [
                "question": "Are you willing to pay a monthly fee to play a game?",
                "options": ["Yes", "No", "It depends"],
                "backend_value_options": ["Willing to Purchase a Subscription", "Not Willing to Purchase a Subscription", "It depends on the Subscription"],
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "subscription_tolerance"
            ],
            [
                "question": "In your lifetime, which of the following have you used? (please select all that apply)",
                "options": ["Jackhammer", "Trident Spear", "Smartphone", "Wrist Watch", "Pencil", "Shears"],
                "multi": true,
                "type": QuestionType.multipleChoice,
                "correctAnswers": ["Smartphone", "Pencil"],
                "isDemographic": false
            ],
            [
                "question": "Which of the following game apps do you enjoy? (please select all that apply)",
                "options": ["First Person Shooter", "Arcade Games", "Sports", "Action/Adventure", "Simulation", "Educational", "Survival", "Strategy", "Puzzle", "Role Playing", "Trivia", "Casino", "Word", "Card", "Racing", "Music"],
                "backend_value_options": ["First Person Shooter", "Arcade Games", "Sports", "Action/Adventure", "Simulation", "Educational", "Survival", "Strategy", "Puzzle", "Role Playing", "Trivia", "Casino", "Word", "Card", "Racing", "Music"],
                "multi": true,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "game_type"
            ],
            [
                "question": "Which of the following apps do you enjoy? (please select all that apply)",
                "options": ["AR Apps", "Books", "Business", "Education", "Entertainment", "Finance", "Food & Drink", "Health & Fitness", "Kids", "Lifestyle", "Magazine & Newspapers", "Medical", "Music", "Navigation", "News", "Photo & Video", "Productivity", "Reference", "Shopping", "Social Networking", "Sports", "Travel", "Utilities", "Weather"],
                "backend_value_options": ["AR Apps", "Books", "Business", "Education", "Entertainment", "Finance", "Food & Drink", "Health & Fitness", "Kids", "Lifestyle", "Magazine & Newspapers", "Medical", "Music", "Navigation", "News", "Photo & Video", "Productivity", "Reference", "Shopping", "Social Networking", "Sports", "Travel", "Utilities", "Weather"],
                "multi": true,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "app_type"
            ],
            [
                "question": "Which games do you prefer?",
                "options": ["Online, Multiplayer games", "Single Player games"],
                "backend_value_options": ["Online, Multiplayer", "Single Player"],
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "game_preference"
            ],
            [
                "question": "What are your thoughts on in-app ads?",
                "options": ["I'll delete an app if I see an ad", "I can tolerate a few here and there", "Ads can be helpful sometimes", "I enjoy looking at ads & discovering new apps"],
                "backend_value_options": ["Zero Ad Tolerance", "Low Ad Tolerance", "Medium Ad Tolerance", "High Ad Tolerance"],
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "ad_tolerance"
            ],
            [
                "question": "What is your Zip/Postal Code?",
                "options": [],
                "multi": false,
                "type": QuestionType.text,
                "isDemographic": true,
                "demographicKey": "country"
            ],
        ]
    }


}
