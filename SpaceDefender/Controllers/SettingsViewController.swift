//
//  SettingsViewController.swift
//  SpaceDefender
//
//  Created by Claudio Facchinetti on 15/08/18.
//  Copyright © 2018 Claudio Facchinetti. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    public static let storageKey = "settings"
    
    public static let fxEffectsOption = "FX Effects"

    public static var options: [String : Bool] = [SettingsViewController.fxEffectsOption: true]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.dataSource = self
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

extension SettingsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SettingsViewController.options.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") as! SettingsTableViewCell
        let startingIndex = SettingsViewController.options.keys.startIndex
        let index = SettingsViewController.options.keys.index(startingIndex, offsetBy: indexPath.row)
        let string = SettingsViewController.options.keys[index]
        cell.lblText.text = string
        cell.chechBox.isOn = SettingsViewController.options[string]!
        return cell
        
    }
    
    
    
    
}
