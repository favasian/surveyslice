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
