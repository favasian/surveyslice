//
//  PreSurveyDetailsViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/22/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit
import SDWebImage

protocol PreSurveyDetailsDelegate: class {
    func tappedToContinueToSurvey(campaign: Campaign, survey: Survey)
    func tappedToVisitUrl(campaign: Campaign, survey: Survey, url: String)
    func tappedToDownloadApp(campaign: Campaign, survey: Survey, url: String)
}


class PreSurveyDetailsViewController: BottomButtonableViewController {
    
    var campaign: Campaign
    var survey: Survey
    var delegate: PreSurveyDetailsDelegate?
    var requiresLinkVisit = false
    var isLinkApp = false
    
    var surveyWallVC: SurveyWallViewController!
    
    init(campaign: Campaign, survey: Survey) {
        self.campaign = campaign
        self.survey = survey
        super.init(nibName: nil, bundle: nil)
        
        if let url = self.survey.preSurveyUrl, url != "" {
            self.requiresLinkVisit = true
            if let appId = self.survey.preSurveyAppStoreId, appId != "" {
                self.isLinkApp = true
                self.bottomBtnTitle = "Download"
                
            } else {
                self.bottomBtnTitle = "Visit"
            }
        } else {
            self.bottomBtnTitle = "Continue"
        }
        
        
//        self.appName = self.survey.preSurveyApp?.name
//        self.minTimeActivity = self.survey.visitedUrlMinimumMinutes
//        self.appImageUrl = self.survey.preSurveyApp?.logo
//        self.appCompanyName = self.survey.preSurveyApp?.developer
//        self.starRating = self.survey.preSurveyApp?.stars

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
        var text1 = "You have been pre-qualified for this survey!"
        if self.requiresLinkVisit {
            if self.isLinkApp {
                var appName = "an app"
                if let an = self.survey.preSurveyApp?.name, an != "" { appName = an }
                if let urlName = self.survey.preSurveyUrlName, urlName != "" { appName = urlName }
                text1 += " To continue with the survey, you must first download \(appName)"
                if let minTime = self.survey.visitedUrlMinimumMinutes, minTime > 0 {
                    if minTime == 1 {
                        text1 += " and use the app for at least 1 minute."
                    } else {
                        text1 += " and use the app for at least \(minTime) minutes."
                    }
                } else {
                    text1 += "."
                }
            } else {
                var siteName = "a website"
                if let urlName = self.survey.preSurveyUrlName, urlName != "" { siteName = urlName }
                text1 += " To continue with the survey, you must first visit \(siteName)"
                if let minTime = self.survey.visitedUrlMinimumMinutes, minTime > 0 {
                    if minTime == 1 {
                        text1 += " and use the site for at least 1 minute."
                    } else {
                        text1 += " and use the site for at least \(minTime) minutes."
                    }
                } else {
                    text1 += "."
                }
            }
        } else {
            text1 += "\n\nTo continue with the survey, click the Continue button below."
        }
        
        label1.text = text1
        label1.font = Globals.appFont()
        label1.textColor = Globals.grayFont
        label1.numberOfLines = 0
        
        self.addSubview(label1)
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.heightAnchor.constraint(equalToConstant: 120).isActive = true
        label1.topAnchor.constraint(equalTo: self.innerView.topAnchor, constant: Globals.smallPadding).isActive = true
        label1.leftAnchor.constraint(equalTo: self.innerView.leftAnchor, constant: Globals.padding).isActive = true
        label1.rightAnchor.constraint(equalTo: self.innerView.rightAnchor, constant: -Globals.padding).isActive = true
        
        var lastLabel = label1
        if let specialNote = self.survey.specialNote, specialNote != "" {
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
            lastLabel = label3
            label3.text = specialNote
            label3.font = Globals.appFont()
            label3.textColor = Globals.grayFont
            label3.numberOfLines = 0
            self.addSubview(label3)
            
            label3.translatesAutoresizingMaskIntoConstraints = false
            label3.heightAnchor.constraint(equalToConstant: 100).isActive = true
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 0).isActive = true
            label3.leftAnchor.constraint(equalTo: self.innerView.leftAnchor, constant: Globals.padding).isActive = true
            label3.rightAnchor.constraint(equalTo: self.innerView.rightAnchor, constant: -Globals.padding).isActive = true
        }
        
        if let preSurveyApp = self.survey.preSurveyApp {
            let appImageView = UIImageView()
            appImageView.layer.cornerRadius = Globals.appIconSize.height/4.0
            appImageView.layer.masksToBounds = true
            self.addSubview(appImageView)
            appImageView.translatesAutoresizingMaskIntoConstraints = false
            appImageView.topAnchor.constraint(equalTo: lastLabel.bottomAnchor, constant: Globals.padding).isActive = true
            appImageView.heightAnchor.constraint(equalToConstant: Globals.appIconSize.height).isActive = true
            appImageView.widthAnchor.constraint(equalToConstant: Globals.appIconSize.width).isActive = true
            appImageView.leftAnchor.constraint(equalTo: self.innerView.leftAnchor, constant: Globals.padding).isActive = true
            appImageView.contentMode = .scaleAspectFit
            
            if let stringURL = self.survey.preSurveyApp?.logo {
                appImageView.sd_setImage(with:  URL(string: stringURL), completed: nil)
            }
            
            
            let appNameLabel = UILabel()
            if let appName = self.survey.preSurveyApp?.name {
                appNameLabel.text = appName
            }
            appNameLabel.font = Globals.appFont()
            appNameLabel.textColor = Globals.grayFont
            appNameLabel.numberOfLines = 0
            
            self.addSubview(appNameLabel)
            appNameLabel.translatesAutoresizingMaskIntoConstraints = false
            appNameLabel.heightAnchor.constraint(equalToConstant: Globals.appIconSize.height/4.0).isActive = true
            appNameLabel.topAnchor.constraint(equalTo: lastLabel.bottomAnchor, constant: Globals.padding).isActive = true
            appNameLabel.leftAnchor.constraint(equalTo: appImageView.rightAnchor, constant: Globals.smallPadding).isActive = true
            appNameLabel.rightAnchor.constraint(equalTo: self.innerView.rightAnchor, constant: -Globals.padding).isActive = true
            
            let appCompanyLabel = UILabel()
            if let appCompanyName = self.survey.preSurveyApp?.developer {
                appCompanyLabel.text = appCompanyName
            }
            appCompanyLabel.font = Globals.appFont()
            appCompanyLabel.textColor = Globals.grayFont
            appCompanyLabel.numberOfLines = 0
            
            self.addSubview(appCompanyLabel)
            appCompanyLabel.translatesAutoresizingMaskIntoConstraints = false
            appCompanyLabel.heightAnchor.constraint(equalToConstant: Globals.appIconSize.height/4.0).isActive = true
            appCompanyLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 0).isActive = true
            appCompanyLabel.leftAnchor.constraint(equalTo: appImageView.rightAnchor, constant: Globals.smallPadding).isActive = true
            appCompanyLabel.rightAnchor.constraint(equalTo: self.innerView.rightAnchor, constant: -Globals.padding).isActive = true
            
            
            
            let starImageView = UIImageView()
            if let stars = self.survey.preSurveyApp?.stars {
                if let starImage = UIImage(named: "\(stars)Stars", in: Globals.appBundle(), compatibleWith: nil) {
                    starImageView.image = starImage
                }
            }
            self.addSubview(starImageView)
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.topAnchor.constraint(equalTo: appCompanyLabel.bottomAnchor, constant: Globals.appIconSize.height/5.0).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: Globals.appIconSize.height/4.0).isActive = true
            starImageView.widthAnchor.constraint(equalToConstant: (Globals.appIconSize.height/4.0)*Globals.starWidthRatio).isActive = true
            starImageView.leftAnchor.constraint(equalTo: appImageView.rightAnchor, constant: Globals.smallPadding).isActive = true
            starImageView.contentMode = .scaleAspectFit
            self.contentMayExceedViewHeight(appImageView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PreSurveyDetailsViewController: BottomButtonDelegate {
    func buttonTapped() {
        if let url = self.survey.preSurveyUrl, url != "" {
            if self.isLinkApp {
                self.delegate?.tappedToDownloadApp(campaign: self.campaign, survey: self.survey, url: url)
            } else {
                self.delegate?.tappedToVisitUrl(campaign: self.campaign, survey: self.survey, url: url)
            }
            if let url = URL(string: url) {
                if UIApplication.shared.canOpenURL(url) {
                    Globals.mainVC.popToRootViewController(animated: false)
                    UIApplication.shared.openURL(url)
                } else {
                    self.displayAlert(title: "Oops", message: "There was an error loading the link") {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            self.delegate?.tappedToContinueToSurvey(campaign: self.campaign, survey: self.survey)
        }
    }
}
