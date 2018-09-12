//
//  FirstViewController.swift
//  SpaceDefender
//
//  Created by Claudio Facchinetti on 15/08/18.
//  Copyright © 2018 Claudio Facchinetti. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    public static let bestScoreKey: String = "bestScore"
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    
    @IBOutlet weak var lblMigliorPunteggio: UILabel!
    
    public static var bestScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateItems()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? GameViewController{
            
            destination.view = nil
            
        }
        
    }
    
    @IBAction func unwindToThis( segue: UIStoryboardSegue ){
        
        self.updateItems()
        
    }
    
    private func updateItems(){
        
        self.lblMigliorPunteggio.text = "Miglior punteggio: \(FirstViewController.bestScore)"
        
    }
    

}
