//
//  AlertViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/2/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class AlertViewController: BaseViewController {
    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var alertTextLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var alertImageView: UIImageView!
    
    var alertTitle: String?
    var alertText: String?
    var btnTitle: String?
    
    public class func instantiate(title: String?, text: String, btnTitle: String="Continue") -> AlertViewController {
        let vc = AlertViewController(nibName: "AlertViewController", bundle: Globals.appBundle())
        vc.alertTitle = title
        vc.alertText = text
        vc.btnTitle = btnTitle
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let title = alertTitle {
            self.alertTitleLabel.text = title
        } else {
            self.alertTitleLabel.text = ""
            if let alertNoTitle = UIImage(named: "alertNoTitle", in: Globals.appBundle(), compatibleWith: nil) {
                self.alertImageView.image = alertNoTitle
            }
        }
        self.alertTextLabel.text = self.alertText
        self.button.setTitle(self.btnTitle, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
    }
}
