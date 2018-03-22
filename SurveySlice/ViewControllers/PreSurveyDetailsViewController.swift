//
//  PreSurveyDetailsViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/22/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class PreSurveyDetailsViewController: BottomButtonableViewController {

    var appName: String!
    var minTimeActivity: Int!
    var appImage: UIImage!
    var appCompanyName: String!
    var starRating: Int!
    var url: String!
    var campaign: [String:Any]!
    
    var surveyWallVC: SurveyWallViewController!
    
    init(campaign: [String:Any], surveyWallVC: SurveyWallViewController) {
        super.init(nibName: nil, bundle: nil)
        self.campaign = campaign
        self.surveyWallVC = surveyWallVC
        self.bottomBtnTitle = "Download"
        self.appName = "Instagram"
        self.minTimeActivity = 10
        guard let appIcon = UIImage(named: "tempAppIcon", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No tempAppIcon Image") }
        self.appImage = appIcon
        self.appCompanyName = "Facebook Inc"
        self.starRating = 4
        self.url = "https://itunes.apple.com/us/app/instagram/id389801252?mt=8"
        self.bottomBtnDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        let label1 = UILabel()
        label1.text = "You have been pre-qualified for this survey! To continue with the survey, you must first download \(appName!) and use the app for at least \(minTimeActivity!) minutes."
        label1.font = Globals.appFont()
        label1.textColor = Globals.grayFont
        label1.numberOfLines = 0
        
        self.addSubview(label1)
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.heightAnchor.constraint(equalToConstant: 120).isActive = true
        label1.topAnchor.constraint(equalTo: self.innerView.topAnchor, constant: Globals.smallPadding).isActive = true
        label1.leftAnchor.constraint(equalTo: self.innerView.leftAnchor, constant: Globals.padding).isActive = true
        label1.rightAnchor.constraint(equalTo: self.innerView.rightAnchor, constant: -Globals.padding).isActive = true
        
        let label2 = UILabel()
        label2.text = "NOTE"
        label2.font = Globals.heavyAppfont()
        label2.textColor = Globals.grayFont
        label2.numberOfLines = 0
        
        self.addSubview(label2)
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: Globals.smallPadding).isActive = true
        label2.leftAnchor.constraint(equalTo: self.innerView.leftAnchor, constant: Globals.padding).isActive = true
        label2.rightAnchor.constraint(equalTo: self.innerView.rightAnchor, constant: -Globals.padding).isActive = true
        
        let label3 = UILabel()
        label3.text = "You will be asked questions about the app to prove that you downloaded and used the app."
        label3.font = Globals.appFont()
        label3.textColor = Globals.grayFont
        label3.numberOfLines = 0
        
        self.addSubview(label3)
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.heightAnchor.constraint(equalToConstant: 100).isActive = true
        label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 0).isActive = true
        label3.leftAnchor.constraint(equalTo: self.innerView.leftAnchor, constant: Globals.padding).isActive = true
        label3.rightAnchor.constraint(equalTo: self.innerView.rightAnchor, constant: -Globals.padding).isActive = true
        
        let appImageView = UIImageView(image: appImage)
        self.addSubview(appImageView)
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        appImageView.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: Globals.padding).isActive = true
        appImageView.heightAnchor.constraint(equalToConstant: Globals.appIconSize.height).isActive = true
        appImageView.widthAnchor.constraint(equalToConstant: Globals.appIconSize.width).isActive = true
        appImageView.leftAnchor.constraint(equalTo: self.innerView.leftAnchor, constant: Globals.padding).isActive = true
        appImageView.contentMode = .scaleAspectFit
        
        let appNameLabel = UILabel()
        appNameLabel.text = self.appName
        appNameLabel.font = Globals.appFont()
        appNameLabel.textColor = Globals.grayFont
        appNameLabel.numberOfLines = 0
        
        self.addSubview(appNameLabel)
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.heightAnchor.constraint(equalToConstant: Globals.appIconSize.height/4.0).isActive = true
        appNameLabel.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: Globals.padding).isActive = true
        appNameLabel.leftAnchor.constraint(equalTo: appImageView.rightAnchor, constant: Globals.smallPadding).isActive = true
        appNameLabel.rightAnchor.constraint(equalTo: self.innerView.rightAnchor, constant: -Globals.padding).isActive = true
        
        let appCompanyLabel = UILabel()
        appCompanyLabel.text = self.appCompanyName
        appCompanyLabel.font = Globals.appFont()
        appCompanyLabel.textColor = Globals.grayFont
        appCompanyLabel.numberOfLines = 0
        
        self.addSubview(appCompanyLabel)
        appCompanyLabel.translatesAutoresizingMaskIntoConstraints = false
        appCompanyLabel.heightAnchor.constraint(equalToConstant: Globals.appIconSize.height/4.0).isActive = true
        appCompanyLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 0).isActive = true
        appCompanyLabel.leftAnchor.constraint(equalTo: appImageView.rightAnchor, constant: Globals.smallPadding).isActive = true
        appCompanyLabel.rightAnchor.constraint(equalTo: self.innerView.rightAnchor, constant: -Globals.padding).isActive = true
    
        guard let starImage = UIImage(named: "\(self.starRating!)Stars", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No \(self.starRating!)Stars Image") }
        
        let starImageView = UIImageView(image: starImage)
        self.addSubview(starImageView)
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.topAnchor.constraint(equalTo: appCompanyLabel.bottomAnchor, constant: Globals.appIconSize.height/5.0).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: Globals.appIconSize.height/4.0).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: (Globals.appIconSize.height/4.0)*Globals.starWidthRatio).isActive = true
        starImageView.leftAnchor.constraint(equalTo: appImageView.rightAnchor, constant: Globals.smallPadding).isActive = true
        starImageView.contentMode = .scaleAspectFit
        
        self.contentMayExceedViewHeight(appImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PreSurveyDetailsViewController: BottomButtonDelegate {
    func buttonTapped() {
        if let url = URL(string: self.url) {
            if UIApplication.shared.canOpenURL(url) {
                self.surveyWallVC.downloadedCampaigns.insert(campaign, at: 0)
                UIApplication.shared.openURL(url)
            }
        }
        
    }
}
