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
    
    var alertTitleLabel: UILabel!
    var alertTextLabel: UILabel!
    var alertImageView: UIImageView!
    
    weak var alertViewDelegate: AlertViewDelegate?
    var alertTitle: String?
    var alertText: String?
    var btnTitle: String?
    var backBtnTitle: String?
    
//    public class func instantiate(title: String?, text: String, backNavBtnTitle: String?, btnTitle: String="Continue") -> AlertViewController {
//        let vc = AlertViewController()
//        vc.alertTitle = title
//        vc.alertText = text
//        vc.btnTitle = btnTitle
//        vc.backBtnTitle = backNavBtnTitle
//        return vc
//    }
    
    init(title: String?, text: String, backNavBtnTitle: String?, btnTitle: String="Continue") {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.alertText = text
        self.btnTitle = btnTitle
        self.backBtnTitle = backNavBtnTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAlert()
        self.bottomBtnDelegate = self
    }
    
    func setupAlertViewButtons() {
        if let title = alertTitle {
            self.alertTitleLabel.text = title
            if let alert = UIImage(named: "alert", in: Globals.appBundle(), compatibleWith: nil) {
                self.alertImageView.image = alert
            }
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
    
    func setupAlert() {
        alertImageView = UIImageView()
        self.addSubview(alertImageView)
        alertImageView.translatesAutoresizingMaskIntoConstraints = false
        alertImageView.centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        alertImageView.centerYAnchor.constraint(equalTo: self.innerView.centerYAnchor, constant: -30).isActive = true
        
        let widthConstraint1 = NSLayoutConstraint(item: alertImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.alertImageSize.width)
        let heightConstraint1 = NSLayoutConstraint(item: alertImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.alertImageSize.height)
        
        self.innerView.addConstraints([widthConstraint1, heightConstraint1])
        
        alertTitleLabel = UILabel()
        self.addSubview(alertTitleLabel)
        alertTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        alertTitleLabel.font = Globals.heavyAppfont()
        alertTitleLabel.textAlignment = .center
        alertTitleLabel.textColor = UIColor.white
        alertTitleLabel.topAnchor.constraint(equalTo: alertImageView.topAnchor, constant: 20).isActive = true
        alertTitleLabel.centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        
        let widthConstraint2 = NSLayoutConstraint(item: alertTitleLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.alertTitleSize.width)
        let heightConstraint2 = NSLayoutConstraint(item: alertTitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.alertTitleSize.height)
        
        self.innerView.addConstraints([widthConstraint2, heightConstraint2])
        
        alertTextLabel = UILabel()
        self.addSubview(alertTextLabel)
        alertTextLabel.translatesAutoresizingMaskIntoConstraints = false
        alertTextLabel.font = Globals.appFont()
        alertTextLabel.textAlignment = .center
        alertTextLabel.textColor = UIColor.white
        alertTextLabel.numberOfLines = 0
        alertTextLabel.adjustsFontSizeToFitWidth = true
        alertTextLabel.topAnchor.constraint(equalTo: alertImageView.topAnchor, constant: 50).isActive = true
        alertTextLabel.centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        
        let widthConstraint3 = NSLayoutConstraint(item: alertTextLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.alertTextSize.width)
        let heightConstraint3 = NSLayoutConstraint(item: alertTextLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.alertTextSize.height)
        
        self.innerView.addConstraints([widthConstraint3, heightConstraint3])
        
        self.setupAlertViewButtons()
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
