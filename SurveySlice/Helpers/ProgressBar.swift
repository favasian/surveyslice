//
//  ProgressBar.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/9/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class ProgressBar: UIView {

    class func newProgressBar() -> ProgressBar {
        let progressbar = ProgressBar.init()
        progressbar.clipsToBounds = true
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
        if let backgroundImage = UIImage(named: "progressBar", in: Globals.appBundle(), compatibleWith: nil) {
            let backgroundView = UIImageView(image: backgroundImage)
            progressbar.addSubview(backgroundView)
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.bottomAnchor.constraint(equalTo: progressbar.bottomAnchor, constant: 0).isActive = true
            backgroundView.topAnchor.constraint(equalTo: progressbar.topAnchor, constant: 0).isActive = true
            backgroundView.leftAnchor.constraint(equalTo: progressbar.leftAnchor, constant: 0).isActive = true
            backgroundView.rightAnchor.constraint(equalTo: progressbar.rightAnchor, constant: 0).isActive = true
            backgroundView.contentMode = .scaleAspectFill
        }
        return progressbar
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
