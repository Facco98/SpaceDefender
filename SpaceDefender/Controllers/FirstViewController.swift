//
//  FirstViewController.swift
//  SpaceDefender
//
//  Created by Claudio Facchinetti on 15/08/18.
//  Copyright © 2018 Claudio Facchinetti. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnPlayDidTap(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "startGameSegue", sender: self)
        
    }
    
    
    @IBAction func btnSettingsDidTap(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "showSettingsSegue", sender: self)
        
    }
    

}
