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
    
    init(numberOfQuestions: Int, currentQuestionNumber: Int, delgate: QuestionViewDelegate) {
        guard let genderSwitchMaleImage = UIImage(named: "genderSwitchMale", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No genderSwitchMale Image") }
        guard let genderSwitchFemaleImage = UIImage(named: "genderSwitchFemale", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No genderSwitchFemale Image") }
        self.genderSwitchMaleImage = genderSwitchMaleImage
        self.genderSwitchFemaleImage = genderSwitchFemaleImage
        super.init(question: "Please select your gender.", numberOfQuestions: numberOfQuestions, currentQuestionNumber: currentQuestionNumber, delgate: delgate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGenderSwitch()
        self.selectedAnswers = ["Male"]
    }
    
    func setupGenderSwitch() {
        genderSwitch = UIButton(type: .custom)
        genderSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(genderSwitch)
        genderSwitch.setImage(self.genderSwitchMaleImage, for: .normal)
        
        genderSwitch.topAnchor.constraint(equalTo: self.questionLabel.bottomAnchor, constant: Globals.padding).isActive = true
        genderSwitch.centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        
        let widthConstraint = NSLayoutConstraint(item: genderSwitch, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.genderSwitchSize.width)
        let heightConstraint = NSLayoutConstraint(item: genderSwitch, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.genderSwitchSize.height)
        self.innerView.addConstraints([widthConstraint, heightConstraint])
        
        genderSwitch.addTarget(self, action: #selector(GenderQuestionViewController.toggleGender), for: .touchUpInside)
    }
    
    @objc func toggleGender() {
        if genderSwitch.image(for: .normal) == genderSwitchMaleImage {
            genderSwitch.setImage(genderSwitchFemaleImage, for: .normal)
            self.selectedAnswers = ["Female"]
        } else {
            genderSwitch.setImage(genderSwitchMaleImage, for: .normal)
            self.selectedAnswers = ["Male"]
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
