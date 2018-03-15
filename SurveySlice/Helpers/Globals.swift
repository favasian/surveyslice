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
    static var answerOptionSize = CGSize(width: 289, height: 60)
    
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
}
