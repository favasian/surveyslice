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
    
    class func appFont(size: CGFloat=16.0) -> UIFont {
        return  UIFont.init(name: "Avenir-Roman", size: size)!
    }
    
    class func heavyAppfont(size: CGFloat=20.0) -> UIFont {
        return  UIFont.init(name: "Avenir-Heavy", size: size)!
    }
    
    class func appBundle() -> Bundle {
        return Bundle(for: self.classForCoder())
    }
}
