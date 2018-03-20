//
//  SubNavSurveyWall.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/20/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class SubNavSurveyWall: UIView {

    init(appIcon: UIImage) {
        super.init(frame: CGRect(x: 0, y: 0, width: Globals.screenWidth(), height: Globals.subNavBarHeight))
        self.translatesAutoresizingMaskIntoConstraints = false
        
        guard let backgroundImage = UIImage(named: "subNavigationBar", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No subNavigationBar Image") }
        let backgroundView = UIImageView(image: backgroundImage)
        self.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.heightAnchor.constraint(equalToConstant: Globals.subNavBarHeight).isActive = true
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        backgroundView.contentMode = .scaleToFill
        
        
        let appIconView = UIImageView(image: appIcon)
        self.addSubview(appIconView)
        appIconView.translatesAutoresizingMaskIntoConstraints = false
        appIconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Globals.subNavSidePadding).isActive = true
        let appIconHeight = Globals.statIconImageSize.height
        appIconView.heightAnchor.constraint(equalToConstant: appIconHeight).isActive = true
        appIconView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        appIconView.widthAnchor.constraint(equalToConstant: appIconHeight).isActive = true
        appIconView.contentMode = .scaleAspectFit
        
        guard let surveySliceImage = UIImage(named: "surveySlice", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No surveySlice Image") }
        let surveySliceView = UIImageView(image: surveySliceImage)
        self.addSubview(surveySliceView)
        surveySliceView.translatesAutoresizingMaskIntoConstraints = false
        surveySliceView.heightAnchor.constraint(equalToConstant: Globals.surveySliceImageSize.height).isActive = true
        surveySliceView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        surveySliceView.leftAnchor.constraint(equalTo: appIconView.rightAnchor, constant: Globals.smallPadding).isActive = true
        surveySliceView.widthAnchor.constraint(equalToConstant: Globals.surveySliceImageSize.width).isActive = true
        surveySliceView.contentMode = .scaleAspectFit
        
        guard let statIconImage = UIImage(named: "statIcon", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No statIcon Image") }
        let statIconView = UIImageView(image: statIconImage)
        self.addSubview(statIconView)
        statIconView.translatesAutoresizingMaskIntoConstraints = false
        statIconView.heightAnchor.constraint(equalToConstant: Globals.statIconImageSize.height).isActive = true
        statIconView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        statIconView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Globals.subNavSidePadding).isActive = true
        statIconView.widthAnchor.constraint(equalToConstant: Globals.statIconImageSize.width).isActive = true
        statIconView.contentMode = .scaleAspectFit
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
