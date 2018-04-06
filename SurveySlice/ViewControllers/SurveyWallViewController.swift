//
//  SurveyWallViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/16/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit
import GameplayKit

class SurveyWallViewController: BottomButtonableViewController {
    
    var lastSurveyPack: UIView?
    var lastRow: UIView?
    var addedViews:[UIView] = []
    var surveyPacks:[SurveyPack] = []
    var headerLabel:UILabel!
    var currency:String!
    var dividerImage: UIImage!
    var alreadyDownloadedCampaigns:[Campaign] = []
    var notYetDownloadedCampaigns:[Campaign] = []
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
        guard let appIcon = UIImage(named: "tempAppIcon", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No tempAppIcon Image") }
        guard let divider = UIImage(named: "divider", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No divider Image") }
        self.dividerImage = divider
        self.currency = Globals.app.devApp!.currency
        
        
        let navBar = SubNavSurveyWall(appIcon: appIcon)
        self.subNavBar = navBar
        super.viewDidLoad()
        self.bottomBtnDelegate = self
        self.bottomBtn.setTitle("Show More Surveys", for: .normal)
        self.setupNavigationBtns()
        self.setupHeaderLabel()
        self.fetchAndRefreshCampaigns()
        self.scrollView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(SurveyWallViewController.displayFetchedSurveyPacks), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    @objc func fetchAndRefreshCampaigns() {
        self.nextPage = nil
        let taskGroup = DispatchGroup()
        taskGroup.enter()
        Campaign.fetch(already_started: true, page: 1) { [weak self] (campaignList) in
            if let campaigns = campaignList?.campaigns {
                self?.alreadyDownloadedCampaigns = campaigns
                self?.campaignIdsViewedThisSession.append(contentsOf: campaigns.map({ (c) -> Int in
                    return c.id
                }))
            } else {
                self?.alreadyDownloadedCampaigns.removeAll()
            }
            taskGroup.leave()
        }
        
        Campaign.fetch(already_started: false, page: 1) { [weak self] (campaignList) in
            if let campaigns = campaignList?.campaigns {
                self?.notYetDownloadedCampaigns = campaigns
            } else {
                self?.notYetDownloadedCampaigns = []
            }
            self?.nextPage = campaignList?.nextPage
            if let _ = campaignList?.nextPage {
                self?.bottomBtn.alpha = 1
            } else {
                self?.bottomBtn.alpha = 0
            }
            taskGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
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
        Campaign.fetch(already_started: false, page: nextPage) { [weak self] (campaignList) in
            if let campaigns = campaignList?.campaigns {
                self?.notYetDownloadedCampaigns.append(contentsOf: campaigns)
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
        if self.alreadyDownloadedCampaigns.count > 0 {
            displaySurveyPacks(self.alreadyDownloadedCampaigns, append: false, header: "Downloaded")
            displaySurveyPacks(self.notYetDownloadedCampaigns, append: true, header: "Ready to Start")
        } else {
            displaySurveyPacks(self.notYetDownloadedCampaigns, append: false)
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
    
    func markAsDownloaded(_ campaign: Campaign) {
        Network.shared.createInstall(campaign: campaign) { (response, error) in
            if error == nil {
                let index = self.notYetDownloadedCampaigns.index(where: { (c1) -> Bool in
                    return c1.id == campaign.id
                })
                if let index = index {
                    self.notYetDownloadedCampaigns.remove(at: index)
                    self.alreadyDownloadedCampaigns.insert(campaign, at: 0)
                }
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
    
    func alreadyDownloaded(_ campaign: Campaign) -> Bool {
        for downloaded in self.alreadyDownloadedCampaigns {
            if campaign.id == downloaded.id { return true }
        }
        return false
    }
    
    func removeFromDownloaded(_ campaign: Campaign) {
        var index = 0
        for downloaded in self.alreadyDownloadedCampaigns {
            if downloaded.id == campaign.id {
                self.alreadyDownloadedCampaigns.remove(at: index)
                return
            }
            index += 1
        }
    }
}

extension SurveyWallViewController: BottomButtonDelegate {
    func buttonTapped() {
        self.fetchAndDisplayMoreCampaigns()
    }
}

extension SurveyWallViewController: SurveyPackDelegate {
    func tapped(campaign: Campaign) {
        if self.alreadyDownloaded(campaign) {
            print("tapped already downloaded")
//            let vc = SurveyViewController(campaign: campaign)
//            vc.surveyDelegate = self
//            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            Network.shared.createClick(campaign: campaign) { (response, error) in
            }
            let vc = PreSurveyDetailsViewController(campaign: campaign)
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//extension SurveyWallViewController: SurveyDelegate  {
//    func surveyCompleted(_ campaign: Campaign) {
//        self.removeFromDownloaded(campaign)
//    }
//}

extension SurveyWallViewController: PreSurveyDetailsDelegate {
    func tappedToContinue(campaign: Campaign) {
        self.markAsDownloaded(campaign)
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
