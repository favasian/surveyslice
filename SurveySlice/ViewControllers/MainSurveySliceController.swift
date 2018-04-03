//
//  SurveySlice.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/16/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class MainSurveySliceController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func dismiss() {
        self.dismiss(animated: true) {
            Globals.app.didDismiss()
        }
    }
    
    class func instantiate() -> MainSurveySliceController {
        let nav = Globals.mainVC
        nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, .font: Globals.appFont(size: 20)]
        if let navImage = UIImage(named: "navigation", in: Globals.appBundle(), compatibleWith: nil) {
            nav.navigationBar.setBackgroundImage(navImage.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        }
        var vc:UIViewController
        if let surveyee = Globals.app.surveyee {
            vc = SurveyWallViewController()
        } else {
             vc = InitialProfiler()
        }
        nav.viewControllers = [vc]
        return nav
    }
    
    func showSurveyWall() {
        self.viewControllers = [SurveyWallViewController()]
    }
}
