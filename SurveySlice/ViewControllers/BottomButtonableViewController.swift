//
//  BottomButtonableViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/9/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

protocol BottomButtonDelegate: class {
    func buttonTapped()
}

class BottomButtonableViewController: BaseViewController {

    var bottomBtn: UIButton!
    weak var bottomBtnDelegate: BottomButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBottomBtn()
    }
    
    func setupBottomBtn() {
        bottomBtn = UIButton(type: .custom)
        bottomBtn.titleLabel?.font = Globals.appFont()
        bottomBtn.setBackgroundImage(UIImage(named: "button", in: Globals.appBundle(), compatibleWith: nil), for: .normal)
        bottomBtn.setBackgroundImage(UIImage(named: "buttonPressed", in: Globals.appBundle(), compatibleWith: nil), for: .selected)
    
        bottomBtn.addTarget(self, action: #selector(BottomButtonableViewController.bottomButtonTapped), for: .touchUpInside)
        self.addSubview(bottomBtn)
        
        bottomBtn.translatesAutoresizingMaskIntoConstraints = false
        bottomBtn.bottomAnchor.constraint(equalTo: self.innerView.bottomAnchor, constant: -10).isActive = true
        bottomBtn.centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        
        let widthConstraint = NSLayoutConstraint(item: bottomBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.bottomBtnSize.width)
        let heightConstraint = NSLayoutConstraint(item: bottomBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.bottomBtnSize.height)
        self.innerView.addConstraints([widthConstraint, heightConstraint])
    }
    
    
    @objc func bottomButtonTapped() {
        self.bottomBtnDelegate?.buttonTapped()
    }
}
