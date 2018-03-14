//
//  GenderQuestionViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/9/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class GenderQuestionViewController: BaseQuestionViewController {
    
    var genderSwitchMaleImage:UIImage!
    var genderSwitchFemaleImage:UIImage!
    var genderSwitch: UIButton!
    
    override func viewDidLoad() {
        self.question = "Please select your gender."
        guard let genderSwitchMaleImage = UIImage(named: "genderSwitchMale", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No genderSwitchMale Image") }
        guard let genderSwitchFemaleImage = UIImage(named: "genderSwitchFemale", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No genderSwitchFemale Image") }
        self.genderSwitchMaleImage = genderSwitchMaleImage
        self.genderSwitchFemaleImage = genderSwitchFemaleImage
        super.viewDidLoad()
        setupGenderSwitch()
        self.selectedAnswers = ["male"]
    }
    
    func setupGenderSwitch() {
        genderSwitch = UIButton(type: .custom)
        genderSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(genderSwitch)
        genderSwitch.setImage(self.genderSwitchMaleImage, for: .normal)
        
        genderSwitch.topAnchor.constraint(equalTo: self.questionLabel.bottomAnchor, constant: Globals.padding).isActive = true
        genderSwitch.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        let widthConstraint = NSLayoutConstraint(item: genderSwitch, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.genderSwitchSize.width)
        let heightConstraint = NSLayoutConstraint(item: genderSwitch, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.genderSwitchSize.height)
        self.view.addConstraints([widthConstraint, heightConstraint])
        
        genderSwitch.addTarget(self, action: #selector(GenderQuestionViewController.toggleGender), for: .touchUpInside)
    }
    
    @objc func toggleGender() {
        if genderSwitch.image(for: .normal) == genderSwitchMaleImage {
            genderSwitch.setImage(genderSwitchFemaleImage, for: .normal)
            self.selectedAnswers = ["female"]
        } else {
            genderSwitch.setImage(genderSwitchMaleImage, for: .normal)
            self.selectedAnswers = ["male"]
        }
    }
    
    override func isValidSelectedAnswers() -> Bool {
        return true
    }

}
