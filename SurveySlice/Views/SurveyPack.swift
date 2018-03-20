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
        
        var bigLabelFont:UIFont!
        var bigLabelHeight:CGFloat!
        var labelSidePadding:CGFloat!
        var smallLabelFont:UIFont!
        var smallLabelHeight: CGFloat!
        var bigLabelTopPadding: CGFloat!
        var smallLabelTopPadding: CGFloat!
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            bigLabelFont = Globals.heavyAppfont(size: 30)
            bigLabelHeight = 30
            labelSidePadding = 40
            smallLabelFont = Globals.appFont(size: 20)
            smallLabelHeight = 23
            bigLabelTopPadding = 60
            smallLabelTopPadding = 15
        } else {
            bigLabelFont = Globals.heavyAppfont()
            bigLabelHeight = 19
            labelSidePadding = 20
            smallLabelFont = Globals.appFont(size: 12)
            smallLabelHeight = 14
            bigLabelTopPadding = 34
            smallLabelTopPadding = 10
        }
        
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
        amountLabel.font = bigLabelFont
        amountLabel.textAlignment = .center
        amountLabel.textColor = UIColor.white
        self.addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        //amountLabel.backgroundColor = UIColor.red
        amountLabel.heightAnchor.constraint(equalToConstant: bigLabelHeight).isActive = true
        amountLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: bigLabelTopPadding).isActive = true
        amountLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: labelSidePadding).isActive = true
        amountLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -labelSidePadding).isActive = true
        
        let currencyLabel = UILabel()
        currencyLabel.text = currency
        currencyLabel.font = bigLabelFont
        currencyLabel.textAlignment = .center
        currencyLabel.textColor = UIColor.white
        self.addSubview(currencyLabel)
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        //amountLabel.backgroundColor = UIColor.red
        currencyLabel.heightAnchor.constraint(equalToConstant: bigLabelHeight).isActive = true
        currencyLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 1).isActive = true
        currencyLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: labelSidePadding).isActive = true
        currencyLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -labelSidePadding).isActive = true
        
        let averageLabel = UILabel()
        averageLabel.text = "Average"
        averageLabel.font = smallLabelFont
        averageLabel.textAlignment = .center
        averageLabel.textColor = Globals.lightGray
        self.addSubview(averageLabel)
        averageLabel.translatesAutoresizingMaskIntoConstraints = false
        averageLabel.heightAnchor.constraint(equalToConstant: smallLabelHeight).isActive = true
        averageLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: smallLabelTopPadding).isActive = true
        averageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: labelSidePadding).isActive = true
        averageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -labelSidePadding).isActive = true
        
        let minuteLabel = UILabel()
        minuteLabel.text = "\(avgTime) min."
        minuteLabel.font = smallLabelFont
        minuteLabel.textAlignment = .center
        minuteLabel.textColor = Globals.lightGray
        self.addSubview(minuteLabel)
        minuteLabel.translatesAutoresizingMaskIntoConstraints = false
        minuteLabel.heightAnchor.constraint(equalToConstant: smallLabelHeight).isActive = true
        minuteLabel.topAnchor.constraint(equalTo: averageLabel.bottomAnchor, constant: 0).isActive = true
        minuteLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: labelSidePadding).isActive = true
        minuteLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -labelSidePadding).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
