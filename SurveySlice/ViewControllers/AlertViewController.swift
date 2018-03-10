//
//  AlertViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/2/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

protocol AlertViewDelegate: class {
    func backNavBtnTapped()
    func bottomBtnTapped()
}

class AlertViewController: BottomButtonableViewController {
    
    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var alertTextLabel: UILabel!
    @IBOutlet weak var alertImageView: UIImageView!
    
    weak var alertViewDelegate: AlertViewDelegate?
    var alertTitle: String?
    var alertText: String?
    var btnTitle: String?
    var backBtnTitle: String?
    
    public class func instantiate(title: String?, text: String, backNavBtnTitle: String?, btnTitle: String="Continue") -> AlertViewController {
        let vc = AlertViewController(nibName: "AlertViewController", bundle: Globals.appBundle())
        vc.alertTitle = title
        vc.alertText = text
        vc.btnTitle = btnTitle
        vc.backBtnTitle = backNavBtnTitle
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAlertViewButtons()
        self.bottomBtnDelegate = self
    }
    
    func setupAlertViewButtons() {
        if let title = alertTitle {
            self.alertTitleLabel.text = title
        } else {
            self.alertTitleLabel.text = ""
            if let alertNoTitle = UIImage(named: "alertNoTitle", in: Globals.appBundle(), compatibleWith: nil) {
                self.alertImageView.image = alertNoTitle
            }
        }
        if let bbt = self.backBtnTitle {
            let btn = UIBarButtonItem(title: bbt, style: .plain, target: self, action: #selector(AlertViewController.backNavBtnPressed))
            btn.tintColor = UIColor.white
            self.navigationItem.setLeftBarButton(btn, animated: false)
        }
        self.alertTextLabel.text = self.alertText
        self.bottomBtn.setTitle(self.btnTitle, for: .normal)
    }

    @objc func backNavBtnPressed() {
        self.alertViewDelegate?.backNavBtnTapped()
    }
}

extension AlertViewController: BottomButtonDelegate {
    func buttonTapped() {
        self.alertViewDelegate?.bottomBtnTapped()
    }
}
