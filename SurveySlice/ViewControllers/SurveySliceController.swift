//
//  SurveySlice.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/16/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

public class SurveySliceController: UINavigationController {

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func cancel() {
        self.dismiss(animated: true) {
        }
    }
    
    public class func instantiate(_ initialProfilerFinished: Bool) -> SurveySliceController {
        let nav = Globals.mainVC
        nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, .font: Globals.appFont(size: 20)]
        if let navImage = UIImage(named: "navigation", in: Globals.appBundle(), compatibleWith: nil) {
            nav.navigationBar.setBackgroundImage(navImage.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        }
        var vc:UIViewController
        //if initialProfilerFinished {
        //} else {
             vc = InitialProfiler()
        //}
        nav.viewControllers = [vc]
        return nav
    }
}
