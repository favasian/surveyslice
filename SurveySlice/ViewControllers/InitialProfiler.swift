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
    
    

    @objc private func cancel() {
        self.dismiss(animated: true) {
        }
    }
    
    public class func instantiate() -> InitialProfiler {
        let nav = InitialProfiler(nibName: "InitialProfiler", bundle: Globals.appBundle())
        nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, .font: Globals.appFont(size: 22)]
        if let navImage = UIImage(named: "navigation", in: Globals.appBundle(), compatibleWith: nil) {
            nav.navigationBar.setBackgroundImage(navImage.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        }
        let vc = AlertViewController.instantiate(title: "Survey Slice", text: "Please complete the following 11 survey questions to earn 200 coins")
        let btn = UIBarButtonItem(title: "Cancel", style: .plain, target: nav, action: #selector(InitialProfiler.cancel))
        btn.tintColor = UIColor.white
        vc.navigationItem.setLeftBarButton(btn, animated: false)
        nav.viewControllers = [vc]
        return nav
    }
}
