//
//  SurveyWallViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/16/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit
import GameplayKit
import SwiftSpinner

class SurveyWallViewController: BottomButtonableViewController {
    
    var lastSurveyPack: UIView?
    var lastRow: UIView?
    var addedViews:[UIView] = []
    var surveyPacks:[SurveyPack] = []
    var headerLabel:UILabel!
    var currency:String!
    var dividerImage: UIImage!
    var alreadyStartedCampaigns:[Campaign] = []
    var notYetStartedCampaigns:[Campaign] = []
    var noSurveyLabel: UILabel!
    var nextPage: Int?
    
    var isDragging = false
    
    var campaignIdsViewedThisSession:[Int] = []
    
    static var packPerRow:Int {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 3
        } else {
            return 2
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        guard let divider = UIImage(named: "divider", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No divider Image") }
        self.dividerImage = divider
        self.currency = Globals.app.devApp!.currency
        
        
        let navBar = SubNavSurveyWall(appIconURL: Globals.app.devApp?.icon)
        self.subNavBar = navBar
        super.viewDidLoad()
        self.bottomBtnDelegate = self
        self.bottomBtn.setTitle("Show More Surveys", for: .normal)
        self.setupNavigationBtns()
        self.setupHeaderLabel()
        self.fetchAndRefreshCampaigns()
        self.scrollView.delegate = self
        
        self.createNoSurveyLabel()
        NotificationCenter.default.addObserver(self, selector: #selector(SurveyWallViewController.displayFetchedSurveyPacks), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    func createNoSurveyLabel() {
        noSurveyLabel = UILabel()
        noSurveyLabel.text = "No surveys available now. Check back later!"
        noSurveyLabel.font = Globals.heavyAppfont()
        noSurveyLabel.textColor = Globals.grayFont
        noSurveyLabel.numberOfLines = 0
        noSurveyLabel.textAlignment = .center
        
        self.view.addSubview(noSurveyLabel)
        noSurveyLabel.translatesAutoresizingMaskIntoConstraints = false
        noSurveyLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        noSurveyLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        noSurveyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        noSurveyLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    
        self.view.sendSubview(toBack: noSurveyLabel)
    }
    
    func showNoSurveyLabel() {
        self.view.bringSubview(toFront: self.noSurveyLabel)
    }
    
    func hideNoSurveyLabel() {
        self.view.sendSubview(toBack: self.noSurveyLabel)
    }
    
    
    @objc func fetchAndRefreshCampaigns() {
        SwiftSpinner.show(duration: 10.00, title: "Loading Surveys...")
        self.nextPage = nil
        let taskGroup = DispatchGroup()
        taskGroup.enter()
        Campaign.fetch(already_started: true, page: 1) { [weak self] (campaignList) in
            if let campaigns = campaignList?.campaigns {
                self?.alreadyStartedCampaigns = campaigns
                self?.campaignIdsViewedThisSession.append(contentsOf: campaigns.map({ (c) -> Int in
                    return c.id
                }))
            } else {
                self?.alreadyStartedCampaigns.removeAll()
            }
            taskGroup.leave()
        }
        
        Campaign.fetch(already_started: false, page: 1) { [weak self] (campaignList) in
            if let campaigns = campaignList?.campaigns {
                self?.notYetStartedCampaigns = campaigns
            } else {
                self?.notYetStartedCampaigns = []
            }
            self?.nextPage = campaignList?.nextPage
            if let _ = campaignList?.nextPage {
                self?.bottomBtn.alpha = 1
            } else {
                self?.bottomBtn.alpha = 0
            }
            taskGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
                SwiftSpinner.hide()
                self?.displayFetchedSurveyPacks()
                Helper.delay(delay: 0.5) { [weak self] in
                    self?.scrollView.setContentOffset(.zero, animated: true)
                    self?.createImpressionsForVisibleCampaigns()
                }
            }))
        }
    }
    
    func fetchAndDisplayMoreCampaigns() {
        guard let nextPage = self.nextPage else { return }
        SwiftSpinner.show("Loading More Surveys...")
        Campaign.fetch(already_started: false, page: nextPage) { [weak self] (campaignList) in
            SwiftSpinner.hide()
            if let campaigns = campaignList?.campaigns {
                self?.notYetStartedCampaigns.append(contentsOf: campaigns)
                self?.displaySurveyPacks(campaigns, append: true, header: nil)
                self?.createImpressionsForVisibleCampaigns()
            }
            self?.nextPage = campaignList?.nextPage
            if let _ = campaignList?.nextPage {
                self?.bottomBtn.alpha = 1
            } else {
                self?.bottomBtn.alpha = 0
            }
        }
    }
    
    @objc func displayFetchedSurveyPacks() {
        self.hideNoSurveyLabel()
        if self.alreadyStartedCampaigns.count > 0 {
            displaySurveyPacks(self.alreadyStartedCampaigns, append: false, header: "Started")
            displaySurveyPacks(self.notYetStartedCampaigns, append: true, header: "Ready to Start")
        } else {
            displaySurveyPacks(self.notYetStartedCampaigns, append: false)
            if self.notYetStartedCampaigns.count == 0 { self.showNoSurveyLabel() }
        }
    }
    
    func setupHeaderLabel() {
        self.headerLabel = newHeaderLabel("Please select a survey to continue and earn \(self.currency!)")
        self.addSubview(self.headerLabel)
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headerLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.headerLabel.topAnchor.constraint(equalTo: self.innerView.topAnchor, constant: Globals.smallPadding).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.innerView.leftAnchor, constant: Globals.padding).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.innerView.rightAnchor, constant: -Globals.padding).isActive = true
    }
    
    func newHeaderLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = Globals.appFont()
        label.textColor = Globals.grayFont
        label.numberOfLines = 0
        return label
    }
    
    func setupNavigationBtns() {
        let btn = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(SurveyWallViewController.backNavBtnPressed))
        btn.tintColor = UIColor.white
        self.navigationItem.setLeftBarButton(btn, animated: false)
        
        guard let refreshImage = UIImage(named: "refresh", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No refresh Image") }
        let refreshBtn = UIBarButtonItem(image: refreshImage, style: .plain, target: self, action: #selector(SurveyWallViewController.fetchAndRefreshCampaigns))
        refreshBtn.width = 20
        self.navigationItem.setRightBarButton(refreshBtn, animated: false)
    }
    
    @objc func backNavBtnPressed() {
        Globals.mainVC.dismiss()
    }
    
    func moveCampaignFromNotStartedToStarted(_ campaign: Campaign) {
        let index = self.notYetStartedCampaigns.index(where: { (c1) -> Bool in
            return c1.id == campaign.id
        })
        if let index = index {
            self.notYetStartedCampaigns.remove(at: index)
            self.alreadyStartedCampaigns.insert(campaign, at: 0)
        }
    }
    
    func markAsInstalled(_ campaign: Campaign) {
        Network.shared.createInstall(campaign: campaign) { [weak self] (response, error) in
            if error == nil {
                self?.moveCampaignFromNotStartedToStarted(campaign)
            }
        }
    }
    
    func markAsPreSurveyUrlOpened(_ campaign: Campaign) {
        Network.shared.createPreSurveyUrlOpen(campaign: campaign) { [weak self] (response, error) in
            if error == nil {
                self?.moveCampaignFromNotStartedToStarted(campaign)
            }
        }
    }
    
    func markAsSurveyStarted(_ campaign: Campaign) {
        Network.shared.createSurveyStart(campaign: campaign) { [weak self] (response, error) in
            if error == nil {
                self?.moveCampaignFromNotStartedToStarted(campaign)
            }
        }
    }
    
    func createImpressionsForVisibleCampaigns() {
        for sp in self.surveyPacks {
            if !self.campaignIdsViewedThisSession.contains(sp.campaign.id) {
                let spFrame = sp.convert(sp.bounds, to: self.view)
                if self.scrollView.frame.contains(spFrame) {
                    self.campaignIdsViewedThisSession.append(sp.campaign.id)
                    Network.shared.createImpression(campaign: sp.campaign) { (response, error) in
                    }
                }
            }

        }
    }
    
    func displaySurveyPacks(_ campaigns: [Campaign], append: Bool=false, header: String?=nil) {
        if !append {
            for row in addedViews { row.removeFromSuperview() }
            self.lastRow = nil
            self.surveyPacks = []
        }
        
        if let headerString = header {
            let divider = UIImageView(image: dividerImage)
            divider.contentMode = .scaleAspectFill
            self.addSubview(divider)
            
            divider.translatesAutoresizingMaskIntoConstraints = false
            divider.heightAnchor.constraint(equalToConstant: Globals.dividerSize.height).isActive = true
            divider.widthAnchor.constraint(equalToConstant: Globals.dividerSize.width).isActive = true
            divider.centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
            if let lastRow = self.lastRow {
                divider.topAnchor.constraint(equalTo: lastRow.bottomAnchor, constant: 0).isActive = true
            } else {
                divider.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: Globals.smallPadding).isActive = true
            }
            self.addedViews.append(divider)
            
            let headerRowLabel = newHeaderLabel(headerString)
            self.addSubview(headerRowLabel)
            headerRowLabel.translatesAutoresizingMaskIntoConstraints = false
            headerRowLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            headerRowLabel.leftAnchor.constraint(equalTo: self.innerView.leftAnchor, constant: Globals.padding).isActive = true
            headerRowLabel.rightAnchor.constraint(equalTo: self.innerView.rightAnchor, constant: -Globals.padding).isActive = true
            headerRowLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 0).isActive = true
            self.addedViews.append(headerRowLabel)
            self.lastRow = headerRowLabel
        }
        
        var columnIndex = 0
        let packPerRow = SurveyWallViewController.packPerRow
        let rowWidth:CGFloat = (CGFloat(packPerRow)*Globals.surveyPackSize.width) + (CGFloat(packPerRow-1)*Globals.smallPadding)
        
        for campaign in campaigns {
            if columnIndex == 0 {
                let newLastRow = UIView()
                self.addSubview(newLastRow)
                newLastRow.translatesAutoresizingMaskIntoConstraints = false
                newLastRow.heightAnchor.constraint(equalToConstant: Globals.surveyPackSize.height).isActive = true
                newLastRow.widthAnchor.constraint(equalToConstant: rowWidth).isActive = true
                newLastRow.centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
                if let lastRow = self.lastRow {
                    newLastRow.topAnchor.constraint(equalTo: lastRow.bottomAnchor, constant: Globals.smallPadding).isActive = true
                } else {
                    newLastRow.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: Globals.smallPadding).isActive = true
                }
                self.addedViews.append(newLastRow)
                self.lastRow = newLastRow
            }
            guard let lastRow = self.lastRow else { fatalError("last row does not exist") }
            
            let sp = SurveyPack(campaign: campaign)
            sp.surveyPackDelegate = self
            lastRow.addSubview(sp)
            surveyPacks.append(sp)
            
            sp.translatesAutoresizingMaskIntoConstraints = false
            sp.heightAnchor.constraint(equalToConstant: Globals.surveyPackSize.height).isActive = true
            sp.widthAnchor.constraint(equalToConstant: Globals.surveyPackSize.width).isActive = true
            
            if columnIndex == 0 {
                sp.topAnchor.constraint(equalTo: lastRow.topAnchor, constant: 0).isActive = true
                sp.leftAnchor.constraint(equalTo: lastRow.leftAnchor, constant: 0).isActive = true
            } else {
                guard let lastSurveyPack = self.lastSurveyPack else { fatalError("should be last survey pack") }
                sp.topAnchor.constraint(equalTo: lastRow.topAnchor).isActive = true
                sp.leftAnchor.constraint(equalTo: lastSurveyPack.rightAnchor, constant: Globals.smallPadding).isActive = true
            }
           
            columnIndex += 1
            if columnIndex >= packPerRow {
                sp.rightAnchor.constraint(equalTo: lastRow.rightAnchor, constant: 0).isActive = true
                columnIndex = 0
            }
            self.lastSurveyPack = sp
        }
        self.contentMayExceedViewHeight(self.lastRow)
    }
    
    func alreadyStarted(campaign: Campaign) -> Bool {
        for started in self.alreadyStartedCampaigns {
            if campaign.id == started.id { return true }
        }
        return false
    }
    
    func removeFromStarted(campaign: Campaign) {
        var index = 0
        for started in self.alreadyStartedCampaigns {
            if started.id == campaign.id {
                self.alreadyStartedCampaigns.remove(at: index)
                return
            }
            index += 1
        }
    }
    
    func startSurvey(campaign: Campaign, survey: Survey) {
        SwiftSpinner.show("Loading Questions...")
        self.markAsSurveyStarted(campaign)
        Question.fetch(forSurvey: survey) { (questions) in
            SwiftSpinner.hide()
            if let questions = questions {
                let vc = SurveyViewController(campaign: campaign, survey: survey, questions: questions)
                vc.surveyDelegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.displayAlert(title: "Oops", message: "Error loading Survey", completion: {
                    
                })
            }
            
        }
    }
    
    func startPreScreenQuestions(campaign: Campaign, survey: Survey) {
        let vc = PreScreenViewController(survey: survey, campaign: campaign, displayIncorrectAnswerAlert: false)
        vc.preScreenDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SurveyWallViewController: BottomButtonDelegate {
    func buttonTapped() {
        self.fetchAndDisplayMoreCampaigns()
    }
}

extension SurveyWallViewController: SurveyPackDelegate {
    func tapped(campaign: Campaign) {
        if self.alreadyStarted(campaign: campaign) {
            SwiftSpinner.show("Loading Survey...")
            Survey.fetch(byCampaignId: campaign.id, checkMinTime: true) { [weak self] (survey) in
                SwiftSpinner.hide()
                if let survey = survey {
                    if let expiration = survey.visitedUrlMinimumMinutesExpiration {
                        if Helper.unixTimestampNow() < expiration {
                            self?.displayAlert(title: "", message: survey.errorStringVisitedUrlMinimumMinutes(timeLeft: expiration-Helper.unixTimestampNow()), completion: {
                                
                            })
                        }
                    }
                    if let preScreenQuestions = survey.preScreenQuestions, preScreenQuestions.count > 0 {
                        self?.startPreScreenQuestions(campaign: campaign, survey: survey)
                    } else {
                        self?.startSurvey(campaign: campaign, survey: survey)
                    }
                } else {
                    self?.displayAlert(title: "Oops", message: "An error occurred", completion: {
                    })
                }
            }
        } else {
            SwiftSpinner.show("Loading Survey...")
            Network.shared.createClick(campaign: campaign) { (response, error) in
            }
            Survey.fetch(byCampaignId: campaign.id, checkMinTime: false)  { [weak self] (survey) in
                SwiftSpinner.hide()
                if let survey = survey {
                    let vc = PreSurveyDetailsViewController(campaign: campaign, survey: survey)
                    vc.delegate = self
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

extension SurveyWallViewController: SurveyDelegate  {
    func surveyCompleted(campaign: Campaign, survey: Survey) {
        self.removeFromStarted(campaign: campaign)
        self.displayFetchedSurveyPacks()
        self.fetchAndRefreshCampaigns()
    }
}

extension SurveyWallViewController: PreSurveyDetailsDelegate {
    
    func tappedToContinueToSurvey(campaign: Campaign, survey: Survey) {
        self.startSurvey(campaign: campaign, survey: survey)
    }
    
    func tappedToVisitUrl(campaign: Campaign, survey: Survey, url: String) {
        //FIXME what to do if it's not an app? still create Install?
        self.markAsPreSurveyUrlOpened(campaign)
    }
    
    func tappedToDownloadApp(campaign: Campaign, survey: Survey, url: String) {
        self.markAsInstalled(campaign)
    }
}

extension SurveyWallViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.isDragging = false
        if !decelerate {
            self.createImpressionsForVisibleCampaigns()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.createImpressionsForVisibleCampaigns()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isDragging = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.isDragging {
            self.createImpressionsForVisibleCampaigns()
        }
        
    }
}

extension SurveyWallViewController: PreScreenDelegate {
    
    func preScreenFinishedSuccessfully(survey: Survey, campaign: Campaign) {
        self.startSurvey(campaign: campaign, survey: survey)
    }
    
}
