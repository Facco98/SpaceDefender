//
//  EndingViewController.swift
//  SpaceDefender
//
//  Created by Claudio Facchinetti on 12/09/18.
//  Copyright © 2018 Claudio Facchinetti. All rights reserved.
//

import UIKit

class EndingViewController: UIViewController {

    public var punteggio: Int = 0
    
    @IBOutlet weak var lblPunteggio: UILabel!
    
    @IBAction func btnBackDidTap(_ sender: Any) {
        
        self.performSegue(withIdentifier: "restart", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblPunteggio.text = "Punteggio: \(self.punteggio)"
        
        if self.punteggio > FirstViewController.bestScore{
            
            FirstViewController.bestScore = self.punteggio
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
