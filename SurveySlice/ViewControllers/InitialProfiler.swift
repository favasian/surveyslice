//
//  InitialProfiler.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/1/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

public class InitialProfiler: UINavigationController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public class func instantiate() -> InitialProfiler {
        let bundle = Bundle(for: self.classForCoder())
        let nav = InitialProfiler(nibName: "InitialProfiler", bundle: bundle)
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.blue
        if let navImage = UIImage(named: "navigation", in: bundle, compatibleWith: nil) {
            nav.navigationBar.setBackgroundImage(navImage.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        }

        nav.viewControllers = [vc]
        return nav
    }

}
