//
//  Globals.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/2/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation


public class Globals: NSObject {
    
    static let mainVC = MainSurveySliceController()
    static let app = SurveySliceApp()
    
    
    
    
    static var bottomBtnSize = CGSize(width: 304, height: 44)
    static var padding:CGFloat = 20
    static var smallPadding:CGFloat = 8
    static var progressBarBackgroundSize: CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: 455, height: 30)
        } else {
            return CGSize(width: 273, height: 18)
        }
    }
    static var progressBarForegroundSize: CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: 455, height: 25)
        } else {
            return CGSize(width: 273, height: 15)
        }
    }
    static var progressBarLabelSize:CGSize = CGSize(width: Globals.screenWidth(), height: 18)
    static var progressBarSize: CGSize = CGSize(width: Globals.progressBarBackgroundSize.width, height: Globals.progressBarBackgroundSize.height + Globals.progressBarLabelSize.height + Globals.smallPadding)
    static var genderSwitchSize = CGSize(width: 118, height: 35)
    static var inputFieldSize = CGSize(width: 150, height: 18)
    static var questionLabelSize = CGSize(width: Globals.screenWidth() * 0.90, height: 50)
    static var alertImageSize = CGSize(width: 243, height: 220)
    static var alertTitleSize = CGSize(width: 199, height: 21)
    static var alertTextSize = CGSize(width: 188, height: 149)
    static var answerOptionSize = CGSize(width: 320, height: 66)
    static var answerOptionInset = UIEdgeInsetsMake(-5, 75, 0, 20)
    static var subNavBarHeight:CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 65
        } else {
            return 45.5
        }
    }
    static var surveySliceImageSize:CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: 209.5, height: 50)
        } else {
            return CGSize(width: 140, height: 33)
        }
    }
    static var statIconImageSize:CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: 45, height: 45)
        } else {
            return CGSize(width: 31, height: 31)
        }
    }
    static var subNavSidePadding:CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 20
        } else {
            return 16
        }
    }
    
    static var appIconSize: CGSize = CGSize(width: 80, height: 80)
    
    static var surveyPackSize:CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: 234.5, height: 216)
        } else {
            return CGSize(width: 142, height: 130)
        }
    }
    static var dividerSize:CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: 768, height: 46)
        } else {
            return CGSize(width: 414, height: 30.67)
        }
    }
    static var starWidthRatio:CGFloat = 5.1599
    
    static var grayFont:UIColor = UIColor.darkGray
    static var lightGray:UIColor = UIColor(hexString: "#939598")!
    
    class func appFont(size: CGFloat=16.0) -> UIFont {
        return  UIFont.init(name: "Avenir-Roman", size: size)!
    }
    
    class func heavyAppfont(size: CGFloat=20.0) -> UIFont {
        return  UIFont.init(name: "Avenir-Heavy", size: size)!
    }
    
    class func appBundle() -> Bundle {
        return Bundle(for: self.classForCoder())
    }
    
    class func screenWidth() -> CGFloat {
        let op1 = UIScreen.main.bounds.width
        let op2 = UIScreen.main.bounds.height
        return min(op1, op2)
    }
    
    class func intialProfilerQAs() -> [[String:Any]] {
        return [
            [
                "question": "Please select your gender.",
                "options": [],
                "multi": false,
                "type": QuestionType.gender
            ],
            [
                "question": "What is your age?",
                "options": [],
                "multi": false,
                "type": QuestionType.number
            ],
            [
                "question": "Take the number between 3 and 5. What is this number minus 2?",
                "options": ["1", "2", "3", "4", "5"],
                "multi": false,
                "type": QuestionType.multipleChoice,
                "correctAnswers": ["2"]
            ],
            [
                "question": "How many hours a week do you spend playing games on your phone?",
                "options": ["0-3 hours", "4-7 hours", "8-13 hours", "14-19 hours", "20+ hours"],
                "multi": false,
                "type": QuestionType.multipleChoice
            ],
            [
                "question": "How much would you estimate you spend on in-app purchases each year?",
                "options": ["Nothing", "$1.00-$5.00", "$5.01-$15.00", "$15.01-$35.00", "$35.01-$50.00", "$50.01-$75.00", "Over $75.00", "Prefer not to answer"],
                "multi": false,
                "type": QuestionType.multipleChoice
            ],
            [
                "question": "Are you willing to pay a monthly fee to play a game?",
                "options": ["Yes", "No", "It depends"],
                "multi": false,
                "type": QuestionType.multipleChoice
            ],
            [
                "question": "In your lifetime, which of the following have you used? (please select all that apply)",
                "options": ["Jackhammer", "Trident Spear", "Smartphone", "Wrist Watch", "Pencil", "Shears"],
                "multi": true,
                "type": QuestionType.multipleChoice,
                "correctAnswers": ["Smartphone", "Pencil"]
            ],
            [
                "question": "Which of the following game apps do you enjoy? (please select all that apply)",
                "options": ["First Person Shooter", "Arcade Games", "Sports", "Action/Adventure", "Simulation", "Educational", "Survival", "Strategy", "Puzzle", "Role Playing", "Trivia", "Casino", "Word", "Card", "Racing", "Music"],
                "multi": true,
                "type": QuestionType.multipleChoice
            ],
            [
                "question": "Which of the following apps do you enjoy? (please select all that apply)",
                "options": ["AR Apps", "Books", "Business", "Education", "Entertainment", "Finance", "Food & Drink", "Health & Fitness", "Kids", "Lifestyle", "Magazine & Newspapers", "Medical", "Music", "Navigation", "News", "Photo & Video", "Productivity", "Reference", "Shopping", "Social Networking", "Sports", "Travel", "Utilities", "Weather"],
                "multi": true,
                "type": QuestionType.multipleChoice
            ],
            [
                "question": "Which games do you prefer?",
                "options": ["Online, Multiplayer games", "Single Player games"],
                "multi": false,
                "type": QuestionType.multipleChoice
            ],
            [
                "question": "What are your thoughts on in-app ads?",
                "options": ["I'll delete an app if I see an ad", "I can tolerate a few here and there", "Ads can be helpful sometimes", "I enjoy looking at ads & discovering new apps"],
                "multi": false,
                "type": QuestionType.multipleChoice
            ],
            [
                "question": "What is your 5-digit Zip Code?",
                "options": [],
                "multi": false,
                "type": QuestionType.number,
                "validations": [AnswerValidation.length: 5]
            ],
        ]
    }
    
    class func dummySurveyQuestions() -> [[String:Any]] {
        return [
            [
                "question": "Did you enjoy using the app?",
                "options": ["Yes", "No"],
                "multi": false,
                "type": QuestionType.multipleChoice
            ],
            [
                "question": "What do you think the app needs work on?",
                "options": ["Useability", "More Visuals", "Not enough content", "Not enough users", "I didn't understand how to use the app"],
                "multi": false,
                "type": QuestionType.multipleChoice
            ],
            [
                "question": "Would you use the app again in the future?",
                "options": ["Yes", "No", "It depends"],
                "multi": false,
                "type": QuestionType.multipleChoice
            ],
            [
                "question": "Would you pay an In App Purchase for more features in the app?",
                "options": ["Yes", "No", "It depends"],
                "multi": false,
                "type": QuestionType.multipleChoice,
            ],
            [
                "question": "How likely would you share this app with your friends or on social media?",
                "options": ["Not likely at all", "Somewhat likely", "Absolutely"],
                "multi": false,
                "type": QuestionType.multipleChoice
            ],
            [
                "question": "Have you used any other app like this before?",
                "options": ["Yes", "No"],
                "multi": false,
                "type": QuestionType.multipleChoice
            ],
            [
                "question": "Which of these apps have you used before (Select all that apply)",
                "options": ["Facebook", "Messenger", "Twitter", "Snapchat"],
                "multi": true,
                "type": QuestionType.multipleChoice
            ]
        ]
    }
}
