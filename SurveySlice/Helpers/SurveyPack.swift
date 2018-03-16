//
//  SurveyPack.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/16/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class SurveyPack: UIView {
    
    init(currencyAmount: Int, currency: String, avgTime: Int=10) {
        super.init(frame: CGRect(x: 0, y: 0, width: Globals.surveyPackSize.width, height: Globals.surveyPackSize.height))
        guard let backgroundImage = UIImage(named: "surveyPack", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No surveyPack Image") }
        let backgroundView = UIImageView(image: backgroundImage)
        self.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.heightAnchor.constraint(equalToConstant: Globals.surveyPackSize.height).isActive = true
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        backgroundView.contentMode = .scaleAspectFill
        
        let amountLabel = UILabel()
        amountLabel.text = "+\(currencyAmount)"
        amountLabel.font = Globals.heavyAppfont()
        amountLabel.textAlignment = .center
        amountLabel.textColor = UIColor.white
        self.addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        //amountLabel.backgroundColor = UIColor.red
        amountLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        amountLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 34).isActive = true
        amountLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        amountLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        let currencyLabel = UILabel()
        currencyLabel.text = currency
        currencyLabel.font = Globals.heavyAppfont()
        currencyLabel.textAlignment = .center
        currencyLabel.textColor = UIColor.white
        self.addSubview(currencyLabel)
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        //amountLabel.backgroundColor = UIColor.red
        currencyLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        currencyLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 1).isActive = true
        currencyLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        currencyLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        let averageLabel = UILabel()
        averageLabel.text = "Average"
        averageLabel.font = Globals.appFont(size: 12)
        averageLabel.textAlignment = .center
        averageLabel.textColor = Globals.lightGray
        self.addSubview(averageLabel)
        averageLabel.translatesAutoresizingMaskIntoConstraints = false
        averageLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        averageLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 10).isActive = true
        averageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        averageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        let minuteLabel = UILabel()
        minuteLabel.text = "\(avgTime) min."
        minuteLabel.font = Globals.appFont(size: 12)
        minuteLabel.textAlignment = .center
        minuteLabel.textColor = Globals.lightGray
        self.addSubview(minuteLabel)
        minuteLabel.translatesAutoresizingMaskIntoConstraints = false
        minuteLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        minuteLabel.topAnchor.constraint(equalTo: averageLabel.bottomAnchor, constant: 0).isActive = true
        minuteLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        minuteLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
