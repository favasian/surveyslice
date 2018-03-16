//
//  SurveyWallViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/16/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class SurveyWallViewController: BaseViewController {

//    public class func instantiate() -> InitialProfiler {
//        let nav = InitialProfiler(nibName: "InitialProfiler", bundle: Globals.appBundle())
//        nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, .font: Globals.appFont(size: 20)]
//        if let navImage = UIImage(named: "navigation", in: Globals.appBundle(), compatibleWith: nil) {
//            nav.navigationBar.setBackgroundImage(navImage.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
//        }
//        let vc = AlertViewController.instantiate(title: "Survey Slice", text: "Please complete the following 11 question survey to earn 200 coins", backNavBtnTitle: "Exit")
//        vc.alertViewDelegate = nav
//        nav.viewControllers = [vc]
//        return nav
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSurveyPacks()
    }
    
    func setupSurveyPacks() {
        let sp = SurveyPack(currencyAmount: 100, currency: "Coins", avgTime: 12.9)
        self.addSubview(sp)
        sp.translatesAutoresizingMaskIntoConstraints = false
        sp.heightAnchor.constraint(equalToConstant: Globals.surveyPackSize.height).isActive = true
        sp.widthAnchor.constraint(equalToConstant: Globals.surveyPackSize.width).isActive = true
        sp.topAnchor.constraint(equalTo: self.innerView.topAnchor, constant: 50).isActive = true
        sp.centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
    }
}
