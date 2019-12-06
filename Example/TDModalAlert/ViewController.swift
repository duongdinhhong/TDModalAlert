//
//  ViewController.swift
//  TDModalAlert
//
//  Created by duongdh93@gmail.com on 12/03/2019.
//  Copyright (c) 2019 duongdh93@gmail.com. All rights reserved.
//

import UIKit
import TDModalAlert

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
    }
    
    @IBAction func showAlertButtonDidTap(_ sender: Any) {
        let alert = TDModalAlertView(frame: view.bounds)
        alert.set(headline: "Success")
        alert.set(message: "You've successfully showed alert !")
        alert.show(in: self)
    }
}

