//
//  BaseViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/2/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var innerView: UIView!
    var scrollView: UIScrollView!
    var constraintInnerViewHeight: NSLayoutConstraint!
    var subNavBar: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.title == "" || self.title == nil {
            self.title = "Survey Slice"
        }
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.setupScrollView()
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
    
    func setupScrollView() {
        scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        if let subNavBar = self.subNavBar {
            self.view.addSubview(subNavBar)
            subNavBar.translatesAutoresizingMaskIntoConstraints = false
            subNavBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
            subNavBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
            subNavBar.heightAnchor.constraint(equalToConstant: Globals.subNavBarHeight).isActive = true
            subNavBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: subNavBar.bottomAnchor, constant: 0).isActive = true
        } else {
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        }
        
        innerView = UIView()
        scrollView.addSubview(innerView)
        innerView.translatesAutoresizingMaskIntoConstraints = false
        innerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        innerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        innerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        innerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        innerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        innerView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, multiplier: 1).isActive = true
        
        constraintInnerViewHeight = innerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1)
        constraintInnerViewHeight.isActive = true
    }
    
    func addSubview(_ view: UIView) {
        self.innerView.addSubview(view)
    }
    
    func contentMayExceedViewHeight(_ bottomMostView: UIView?=nil) {
        constraintInnerViewHeight.isActive = false
        if let bmv = bottomMostView {
            bmv.bottomAnchor.constraint(lessThanOrEqualTo: self.innerView.bottomAnchor, constant: -Globals.padding).isActive = true
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
