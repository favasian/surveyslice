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
    var surveyPackRows:[UIView] = []
    static var packPerRow:Int {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 3
        } else {
            return 2
        }
    }
    
    
    override func viewDidLoad() {
        guard let appIcon = UIImage(named: "tempAppIcon", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No tempAppIcon Image") }
        let navBar = SubNavSurveyWall(appIcon: appIcon)
        self.subNavBar = navBar
        super.viewDidLoad()
        self.bottomBtnDelegate = self
        self.bottomBtn.setTitle("Show More Surveys", for: .normal)
        let campaigns:[[String: Any]] = self.moreCampaigns()
        displaySurveyPacks(campaigns)
        self.setupNavigationBtns()
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
        let campaigns:[[String: Any]] = self.moreCampaigns()
        displaySurveyPacks(campaigns)
        Helper.delay(delay: 0.5) {
            self.scrollView.setContentOffset(.zero, animated: true)
        }
    }
    
    @objc func backNavBtnPressed() {
        Globals.mainVC.dismiss(animated: true) {
        }
    }
    
    func moreCampaigns() -> [[String: Any]] {
        var array = [
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
        return GKRandomSource.sharedRandom().arrayByShufflingObjects(in: array) as! [[String: Any]]
    }
    
    func displaySurveyPacks(_ campaigns: [[String: Any]], append: Bool=false) {
        if !append {
            for row in surveyPackRows { row.removeFromSuperview() }
            self.lastRow = nil
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
                    newLastRow.topAnchor.constraint(equalTo: self.innerView.topAnchor, constant: Globals.smallPadding).isActive = true
                }
                self.surveyPackRows.append(newLastRow)
                self.lastRow = newLastRow
            }
            guard let lastRow = self.lastRow else { fatalError("last row does not exist") }
            guard let currencyAmount = campaign["currencyAmount"] as? Int else { fatalError("currency amount does not exist") }
            guard let currency = campaign["currency"] as? String else { fatalError("currency does not exist") }
            guard let avgTime = campaign["avgTime"] as? Int else { fatalError("avgTime does not exist") }
            let sp = SurveyPack(currencyAmount: currencyAmount, currency: currency, avgTime: avgTime)
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
