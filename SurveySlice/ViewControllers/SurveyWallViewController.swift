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
    var headerLabel:UILabel!
    var currency:String!
    var dividerImage: UIImage!
    var downloadedCampaigns:[[String:Any]] = []
    
    static var packPerRow:Int {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 3
        } else {
            return 2
        }
    }
    
    
    override func viewDidLoad() {
        guard let appIcon = UIImage(named: "tempAppIcon", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No tempAppIcon Image") }
        guard let divider = UIImage(named: "divider", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No divider Image") }
        self.dividerImage = divider
        self.currency = "Coins"
        
        
        let navBar = SubNavSurveyWall(appIcon: appIcon)
        self.subNavBar = navBar
        super.viewDidLoad()
        self.bottomBtnDelegate = self
        self.bottomBtn.setTitle("Show More Surveys", for: .normal)
        self.setupNavigationBtns()
        self.setupHeaderLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.displayDownloadedAndReadySurveyPacks()
    }
    
    func displayDownloadedAndReadySurveyPacks() {
        let campaigns:[[String: Any]] = self.moreCampaigns()
        if self.downloadedCampaigns.count > 0 {
            displaySurveyPacks(self.downloadedCampaigns, append: false, header: "Downloaded")
            displaySurveyPacks(campaigns, append: true, header: "Ready to Start")
        } else {
            displaySurveyPacks(campaigns, append: false)
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
        let refreshBtn = UIBarButtonItem(image: refreshImage, style: .plain, target: self, action: #selector(SurveyWallViewController.refreshSurveyPacks))
        refreshBtn.width = 20
        self.navigationItem.setRightBarButton(refreshBtn, animated: false)
    }
    
    @objc func refreshSurveyPacks() {
        self.displayDownloadedAndReadySurveyPacks()
        Helper.delay(delay: 0.5) {
            self.scrollView.setContentOffset(.zero, animated: true)
        }
    }
    
    @objc func backNavBtnPressed() {
        Globals.mainVC.dismiss(animated: true) {
        }
    }
    
    func moreCampaigns(_ count:Int=12) -> [[String: Any]] {
        let array:[[String:Any]] = [
            ["currencyAmount": 100, "currency": "Coins", "avgTime": 2],
            ["currencyAmount": 500, "currency": "Coins", "avgTime": 5],
            ["currencyAmount": 300, "currency": "Coins", "avgTime": 3],
            ["currencyAmount": 200, "currency": "Coins", "avgTime": 12],
            ["currencyAmount": 100, "currency": "Coins", "avgTime": 10],
            ["currencyAmount": 100, "currency": "Coins", "avgTime": 1],
            ["currencyAmount": 600, "currency": "Coins", "avgTime": 4],
            ["currencyAmount": 700, "currency": "Coins", "avgTime": 3],
            ["currencyAmount": 350, "currency": "Coins", "avgTime": 12],
            ["currencyAmount": 200, "currency": "Coins", "avgTime": 13],
            ["currencyAmount": 250, "currency": "Coins", "avgTime": 12],
            ["currencyAmount": 100, "currency": "Coins", "avgTime": 3]
        ]
        var campaigns:[[String:Any]] = []
        var index = 0
        for a in array {
            campaigns.append(a)
            index += 1
            if index > count { break }
        }
        return GKRandomSource.sharedRandom().arrayByShufflingObjects(in: campaigns) as! [[String: Any]]
    }
    
    func displaySurveyPacks(_ campaigns: [[String: Any]], append: Bool=false, header: String?=nil) {
        if !append {
            for row in addedViews { row.removeFromSuperview() }
            self.lastRow = nil
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
}

extension SurveyWallViewController: BottomButtonDelegate {
    func buttonTapped() {
        var campaigns = self.moreCampaigns()
        self.displaySurveyPacks(campaigns, append: true)
    }
}

extension SurveyWallViewController: SurveyPackDelegate {
    func tapped(campaign: [String:Any]) {
        let vc = PreSurveyDetailsViewController(campaign: campaign, surveyWallVC: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
