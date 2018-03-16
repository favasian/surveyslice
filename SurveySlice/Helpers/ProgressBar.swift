//
//  ProgressBar.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/9/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class ProgressBar: UIView {

    var steps: Int!
    var currentStep: Int!
    
    class func newProgressBar(steps: Int, currentStep: Int=1) -> ProgressBar {
        let progressbar = ProgressBar.init()
        progressbar.clipsToBounds = true
        progressbar.steps = steps
        progressbar.currentStep = currentStep
        
        guard let backgroundImage = UIImage(named: "progressBarGroove", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No progressBarGroove Image") }
        let backgroundView = UIImageView(image: backgroundImage)
        progressbar.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.heightAnchor.constraint(equalToConstant: (Globals.progressBarSize.height-Globals.smallPadding)/2.0)
        backgroundView.topAnchor.constraint(equalTo: progressbar.topAnchor, constant: 0).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: progressbar.leftAnchor, constant: 0).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: progressbar.rightAnchor, constant: 0).isActive = true
        backgroundView.contentMode = .scaleAspectFill
        
        guard let barImage = UIImage(named: "progressBar", in: Globals.appBundle(), compatibleWith: nil) else { fatalError("No progressBarGroove Image") }
        let barView = UIImageView(image: barImage)
        progressbar.addSubview(barView)
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -1).isActive = true
        barView.topAnchor.constraint(equalTo: progressbar.topAnchor, constant: 1).isActive = true
        
        var m:CGFloat
        if steps == currentStep {
            m = 0
        } else {
            m = ((CGFloat(currentStep-1)/CGFloat(steps))*Globals.progressBarSize.width) - Globals.progressBarSize.width
        }
        
        barView.leftAnchor.constraint(equalTo: progressbar.leftAnchor, constant: m).isActive = true
        
        let widthConstraint = NSLayoutConstraint(item: barView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.progressBarSize.width)
        progressbar.addConstraints([widthConstraint])
        
        barView.contentMode = .scaleAspectFill
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        progressbar.addSubview(label)
        label.font = Globals.appFont()
        label.textColor = Globals.grayFont
        label.textAlignment = .center
        label.text = "Question \(currentStep)/\(steps)"
        label.leftAnchor.constraint(equalTo: progressbar.leftAnchor, constant: 0).isActive = true
        label.rightAnchor.constraint(equalTo: progressbar.rightAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: progressbar.bottomAnchor, constant: 0).isActive = true
        label.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: Globals.smallPadding).isActive = true
        label.heightAnchor.constraint(equalToConstant: (Globals.progressBarSize.height-Globals.smallPadding)/2.0).isActive = true
        return progressbar
    }
    
    

}
