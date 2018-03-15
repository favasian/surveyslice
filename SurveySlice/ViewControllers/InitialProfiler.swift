//
//  InitialProfiler.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/1/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

public class InitialProfiler: UINavigationController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @objc private func cancel() {
        self.dismiss(animated: true) {
        }
    }
    
    public class func instantiate() -> InitialProfiler {
        let nav = InitialProfiler(nibName: "InitialProfiler", bundle: Globals.appBundle())
        nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, .font: Globals.appFont(size: 20)]
        if let navImage = UIImage(named: "navigation", in: Globals.appBundle(), compatibleWith: nil) {
            nav.navigationBar.setBackgroundImage(navImage.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        }
        let vc = AlertViewController.instantiate(title: "Survey Slice", text: "Please complete the following 11 question survey to earn 200 coins", backNavBtnTitle: "Exit")
        vc.alertViewDelegate = nav
        nav.viewControllers = [vc]
        return nav
    }
    
    private func startQuestion(questionNumber: Int=0) {
        var qvc:BaseQuestionViewController!
        let numberOfQuestions = 11
        switch questionNumber {
        case 0:
            //qvc = GenderQuestionViewController(numberOfQuestions: numberOfQuestions, currentQuestionNumber: questionNumber, delgate: self)
            qvc = MultipleChoiceQuestionViewController(question: "Take the number between 3 and 5. What is this number minus 2?", numberOfQuestions: numberOfQuestions, currentQuestionNumber: questionNumber, delgate: self, options: ["1", "2", "3", "4"], multiSelect: false)
        case 1:
            qvc = AgeQuestionViewController(numberOfQuestions: numberOfQuestions, currentQuestionNumber: questionNumber, delgate: self)
        case 2:
            qvc = MultipleChoiceQuestionViewController(question: "Take the number between 3 and 5. What is this number minus 2?", numberOfQuestions: numberOfQuestions, currentQuestionNumber: questionNumber, delgate: self, options: ["1", "2", "3", "4"], multiSelect: false)
        default:
            print("default")
        }
        self.pushViewController(qvc, animated: true)
    }
}

extension InitialProfiler: AlertViewDelegate {
    func backNavBtnTapped() {
        self.cancel()
    }
    
    func bottomBtnTapped() {
        self.startQuestion()
    }
}

extension InitialProfiler: QuestionViewDelegate {
    func submittedAnswers(answers: [String]?, questionNumber: Int) {
        if let answers = answers {
            print(answers.joined(separator: ","))
        }
        self.startQuestion(questionNumber: questionNumber+1)
    }
}
