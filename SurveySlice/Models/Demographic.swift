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
                "question": "What is your birthday?",
                "options": [],
                "multi": false,
                "type": QuestionType.dob,
                "isDemographic": true,
                "demographicKey": "dob"
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
                "demographicKey": "zip"
            ],
            [
                "question": "What country do live in?",
                "options": [],
                "multi": false,
                "type": QuestionType.country,
                "isDemographic": true,
                "demographicKey": "country"
            ],
            [
                "question": "Are you the parent of any children below the age of 18?",
                "options": ["Yes", "No"],
                "backend_value_options": Array(1...2).map({ (i) -> String in return "\(i)" }),
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "hasChildren"
            ],
            [
                "question": "What is your employment status? (check all that apply)",
                "options": ["Student", "Employed Part-Time", "Employed Full-Time", "Not currently employed", "Retired", "Self-employed", "Stay-at-home spouse or partner"],
                "backend_value_options": Array(1...7).map({ (i) -> String in return "\(i)" }),
                "multi": true,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "employment"
            ],
            [
                "question": "How many of your children under the age of 18 live in your home?",
                "options": ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "More than 10"],
                "backend_value_options": Array(1...12).map({ (i) -> String in return "\(i)" }),
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "howManyChildren"
            ],
            [
                "question": "In which of the following industries are you currently employed?",
                "options": ["Accounting", "Advertising/PR", "Aerospace/Defense", "Agriculture/Fishing", "Architecture", "Arts/Entertainment", "Athletics/Sports", "Automotive", "Aviation", "Banking/Financial", "Basic Materials - Metals, Minerals, Oil, Chemicals", "Bio-Tech", "Brokerage", "Business Services", "Carpenting/Electrical installations/VVS", "Chemicals/Plastics/Rubber", "Communication/Information", "Computer Electronic Equipment/Hardware", "Computer Reseller (software/hardware)", "Computer Software, Storage, Security", "Construction", "Consulting", "Consumer Electronics", "Consumer Packaged Goods", "Dentistry", "Education", "Employment", "Engineering", "Environmental Services", "Equipment", "Fashion/Apparel", "Fitness", "Food and Beverage", "Government/Public Sector", "Healthcare", "Hospitality/Tourism/Travel", "Human Resources", "Industrial Goods", "Information Technology", "Insurance", "Internet/Web Development", "Legal/Law", "Manufacturing", "Market Research", "Marketing/Sales", "Media/Entertainment", "Military", "Nonprofit/Charity/Social Services/Religious Organization", "Personal Services", "Pharmaceuticals", "Publishing/Printing/Print Media", "Real-Estate/Property", "Recreation", "Retail", "Security", "Shipping/Distribution", "Training Consulting", "Transportation", "Utilities/Telecom", "Veterinary Services", "Waste Management", "Wholesale", "Other", "None / I do not work"],
                "backend_value_options": Array(1...64).map({ (i) -> String in return "\(i)" }),
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "employmentIndustry"
            ],
            [
                "question": "Which of these best describes your job title?",
                "options": ["Business Owner", "C-level Executive", "V.P./Director", "Mid-level Management", "Entry-level", "Technical/IT", "Sales/Business Development", "Purchasing/Procurement", "Human Resources", "Engineer", "Programmer", "Clerical/Administrative/Support Staff/General Staff", "Military/Law Enforcement", "Foreman/Contractor", "Cook/Chef", "Unskilled Labor", "Teacher/Professor", "Psychologist/Counselor", "Medical Professional", "Legal/Law", "CPA", "I do not work", "Other", "Customer Service/Client Service", "Finance/Accounting", "Professional Photographer/Film Maker/Videographer"],
                "backend_value_options": Array(1...26).map({ (i) -> String in return "\(i)" }),
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "jobTitle"
            ],
            [
                "question": "What language do you primarily speak at home?",
                "options":["English", "French", "Spanish", "German", "Italian", "Portuguese", "Mandarin", "Cantonese", "Japanese", "Arabic", "Other", "Indonesian", "Korean", "Malay", "Russian", "Thai", "Turkish", "Vietnamese", "Hindi", "Swahili", "Polish", "Romanian", "Ukrainian", "Dutch", "Punjabi"],
                "backend_value_options": Array(1...25).map({ (i) -> String in return "\(i)" }),
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "language"
            ],
            [
                "question": "What is your marital status?",
                "options": ["Single, never married", "Engaged", "Married", "Living with Partner", "Separated", "Divorced", "Widowed", "Civil Union / Civil Partnership", "Prefer not to answer"],
                "backend_value_options": Array(1...9).map({ (i) -> String in return "\(i)" }),
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "maritalStatus"
            ],
            [
                "question": "Which of the following best describes your racial and ethnic background?",
                "options": ["Black or African American", "Asian, South East Asian", "White or Caucasian", "Hawaiian or Pacific Islander", "Hispanic or Latino", "Native American, Alaska Native, Aleutian", "Prefer not to answer"],
                "backend_value_options": Array(1...7).map({ (i) -> String in return "\(i)" }),
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "ethnicityUS"
            ],
            [
                "question": "Which of the following income ranges best describes your household's total income before taxes last year (USD)?",
                "options": ["Less than $5,000", "$5,000 to $9,999", "$10,000 to $14,999", "$15,000 to $19,999", "$20,000 to $24,999", "$25,000 to $29,999", "$30,000 to $34,999", "$35,000 to $39,999", "$40,000 to $44,999", "$45,000 to $49,999", "$50,000 to $54,999", "$55,000 to $59,999", "$60,000 to $64,999", "$65,000 to $69,999", "$70,000 to $74,999", "$75,000 to $79,999", "$80,000 to $89,999", "$90,000 to $99,999", "$100,000 to $124,999", "$125,000 to $149,999", "$150,000 to $199,999", "$200,000 to $249,999", "$250,000 to $499,999", "More than $500,000", "Prefer not to answer", "Not Sure"],
                "backend_value_options": Array(1...26).map({ (i) -> String in return "\(i)" }),
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "householdIncomePlusUS"
            ],
            [
                "question": "Which of the following, if any, is the highest educational or professional qualification you have obtained?",
                "options":["Elementary School", "Middle School/Junior High", "Some High School", "High School Graduate", "Some College or Technical School", "College or Technical School Graduate", "Graduate School Degree", "Doctoral Degree", "Other"],
                "backend_value_options": Array(1...9).map({ (i) -> String in return "\(i)" }),
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "educationUS"
            ],
            [
                "question": "Approximately how many employees work at your organization (all locations)?",
                "options":["1-10", "11-50", "51-100", "101-500", "501-1000", "1001-5000", "Greater than 5000", "I do not work/I do not know"],
                "backend_value_options": Array(1...8).map({ (i) -> String in return "\(i)" }),
                "multi": false,
                "type": QuestionType.multipleChoice,
                "isDemographic": true,
                "demographicKey": "employees_number"
            ],
        ]
    }


}
