//
//  InitialProfiler.swift
//  SurveySlice
//
//  Created by Christopher Li on 2/28/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

public class InitialProfiler: UIViewController {

    @IBOutlet weak var label: UILabel!
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label.text = "WHOOOOAAAAAA"
    }

    public class func instantiate() -> InitialProfiler {
        let bundle = Bundle(for: self.classForCoder())
        return InitialProfiler(nibName: "InitialProfiler", bundle: bundle)
    }
}
