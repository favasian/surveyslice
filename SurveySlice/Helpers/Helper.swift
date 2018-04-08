//
//  Helper.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/14/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import Foundation

public class Helper: NSObject {
    class func delay(delay: TimeInterval, block: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            block()
        }
    }
    
    class func logError(_ str: String) {
        print("[SurveySlice] ERROR: \(str)")
    }
    
    class func logInfo(_ str: String) {
        print("[SurveySlice] INFO: \(str)")
    }
    
    class func logWarning(_ str: String) {
        print("[SurveySlice] WARNING: \(str)")
    }
    
    class func unixTimestampNow() -> Int {
        return Int(Date().timeIntervalSince1970)
    }
}

