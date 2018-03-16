//
//  SurveyPack.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/16/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class SurveyPack: UIView {
    
    init(currencyAmount: Int, currency: String, avgTime: Double) {
        super.init(frame: CGRect(x: 0, y: 0, width: Globals.surveyPackSize.width, height: Globals.surveyPackSize.height))
        guard let backgroundImage = UIImage(named: "surveyPack", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No surveyPack Image") }
        let backgroundView = UIImageView(image: backgroundImage)
        self.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.heightAnchor.constraint(equalToConstant: Globals.surveyPackSize.height).isActive = true
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        backgroundView.contentMode = .scaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
