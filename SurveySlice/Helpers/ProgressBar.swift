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
    
    class func newProgressBar(steps: Int, currentStep: Int=0) -> ProgressBar {
        let progressbar = ProgressBar.init()
        progressbar.clipsToBounds = true
        progressbar.steps = steps
        progressbar.currentStep = currentStep
        if let backgroundImage = UIImage(named: "progressBarGroove", in: Globals.appBundle(), compatibleWith: nil) {
            let backgroundView = UIImageView(image: backgroundImage)
            progressbar.addSubview(backgroundView)
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.bottomAnchor.constraint(equalTo: progressbar.bottomAnchor, constant: 0).isActive = true
            backgroundView.topAnchor.constraint(equalTo: progressbar.topAnchor, constant: 0).isActive = true
            backgroundView.leftAnchor.constraint(equalTo: progressbar.leftAnchor, constant: 0).isActive = true
            backgroundView.rightAnchor.constraint(equalTo: progressbar.rightAnchor, constant: 0).isActive = true
            backgroundView.contentMode = .scaleAspectFill
        }
        if let barImage = UIImage(named: "progressBar", in: Globals.appBundle(), compatibleWith: nil) {
            let barView = UIImageView(image: barImage)
            progressbar.addSubview(barView)
            barView.translatesAutoresizingMaskIntoConstraints = false
            barView.bottomAnchor.constraint(equalTo: progressbar.bottomAnchor, constant: -1).isActive = true
            barView.topAnchor.constraint(equalTo: progressbar.topAnchor, constant: 1).isActive = true
            
            let m = ((CGFloat(currentStep)/CGFloat(steps))*Globals.progressBarSize.width) - Globals.progressBarSize.width
            barView.leftAnchor.constraint(equalTo: progressbar.leftAnchor, constant: m).isActive = true
            
            let widthConstraint = NSLayoutConstraint(item: barView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.progressBarSize.width)
            progressbar.addConstraints([widthConstraint])
            
            barView.contentMode = .scaleAspectFill
        }
        return progressbar
    }
    
    

}
