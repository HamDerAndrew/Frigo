//
//  SecondViewController.swift
//  Frigo
//
//  Created by André Larsen on 28/01/2020.
//  Copyright © 2020 André Larsen. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    //Hide back button on tabnavigation
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = "Historik"
    }


}

