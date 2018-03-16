//
//  SurveyWallViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/16/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class SurveyWallViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSurveyPacks()
    }
    
    func setupSurveyPacks() {
        let sp = SurveyPack(currencyAmount: 100, currency: "Coins", avgTime: 12)
        self.addSubview(sp)
        sp.translatesAutoresizingMaskIntoConstraints = false
        sp.heightAnchor.constraint(equalToConstant: Globals.surveyPackSize.height).isActive = true
        sp.widthAnchor.constraint(equalToConstant: Globals.surveyPackSize.width).isActive = true
        sp.topAnchor.constraint(equalTo: self.innerView.topAnchor, constant: 50).isActive = true
        sp.centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
    }
}
