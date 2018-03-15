//
//  Globals.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/2/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation


public class Globals: NSObject {
    
    static var bottomBtnSize = CGSize(width: 304, height: 44)
    static var padding:CGFloat = 20
    static var smallPadding:CGFloat = 8
    static var progressBarSize = CGSize(width: Globals.screenWidth() * 0.80, height: 36+Globals.smallPadding)
    static var genderSwitchSize = CGSize(width: 118, height: 35)
    static var inputFieldSize = CGSize(width: 150, height: 18)
    static var questionLabelSize = CGSize(width: Globals.screenWidth() * 0.90, height: 36)
    static var alertImageSize = CGSize(width: 243, height: 220)
    static var alertTitleSize = CGSize(width: 199, height: 21)
    static var alertTextSize = CGSize(width: 188, height: 149)
    static var answerOptionSize = CGSize(width: 320, height: 66)
    static var answerOptionInset = UIEdgeInsetsMake(-5, 75, 0, 20)
    
    static var grayFont:UIColor = UIColor.darkGray
    
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
    
    class func intialProfilerMultipleQAs() -> [[String:Any]] {
        return [
            [
                "question": "Take the number between 3 and 5. What is this number minus 2?",
                "answers": ["1", "2", "3", "4", "5"],
                "multi": false
            ],
            [
                "question": "How many hours a week do you spend playing games on your phone?",
                "answers": ["0-3 hours", "4-7 hours", "8-13 hours", "14-19 hours", "20+ hours"],
                "multi": false
            ],
            [
                "question": "How much would you estimate you spend on in-app purchases each year?",
                "answers": ["Nothing", "$1.00-$5.00", "$5.01-$15.00", "$15.01-$35.00", "$35.01-$50.00", "$50.01-$75.00", "Over $75.00", "Prefer not to answer"],
                "multi": false
            ],
            [
                "question": "Are you willing to pay a monthly fee to play a game?",
                "answers": ["Yes", "No", "It depends"],
                "multi": false
            ],
            [
                "question": "In your lifetime, which of the following have you used? (please select all that apply)",
                "answers": ["Jackhammer", "Trident Spear", "Smartphone", "Wrist Watch", "Pencil", "Shears"],
                "multi": true
            ],
            [
                "question": "Which of the following game apps do you enjoy? (please select all that apply)",
                "answers": ["First Person Shooter", "Arcade Games", "Sports", "Action/Adventure", "Simulation", "Educational", "Survival", "Strategy", "Puzzle", "Role Playing", "Trivia", "Casino", "Word", "Card", "Racing", "Music"],
                "multi": true
            ],
            [
                "question": "Which of the following apps do you enjoy? (please select all that apply)",
                "answers": ["AR Apps", "Books", "Business", "Education", "Entertainment", "Finance", "Food & Drink", "Health & Fitness", "Kids", "Lifestyle", "Magazine & Newspapers", "Medical", "Music", "Navigation", "News", "Photo & Video", "Productivity", "Reference", "Shopping", "Social Networking", "Sports", "Travel", "Utilities", "Weather"],
                "multi": true
            ],
            [
                "question": "Which games do you prefer?",
                "answers": ["Online, Multiplayer games", "Single Player games"],
                "multi": false
            ],
            [
                "question": "What are your thoughts on in-app ads?",
                "answers": ["I'll delete an app if I see an ad", "I can tolerate a few here and there", "Ads can be helpful sometimes", "I enjoy looking at ads & discovering new apps"],
                "multi": false
            ]
        ]
    }
}
