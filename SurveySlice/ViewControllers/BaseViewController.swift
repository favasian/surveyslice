//
//  BaseViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/2/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.title == "" || self.title == nil {
            self.title = "Survey Slice"
        }
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.setupBackgroundImage()
    }

    func setupBackgroundImage() {
        if let backgroundImage = UIImage(named: "background", in: Globals.appBundle(), compatibleWith: nil) {
            let backgroundView = UIImageView(image: backgroundImage)
            self.view.addSubview(backgroundView)
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
            backgroundView.contentMode = .scaleAspectFill
            
            self.view.sendSubview(toBack: backgroundView)
        }
    }
 
    func displayAlert(title: String, message: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default) { (alertAction) in
            completion()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
