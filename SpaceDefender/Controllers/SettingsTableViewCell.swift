//
//  SettingsTableViewCell.swift
//  SpaceDefender
//
//  Created by Claudio Facchinetti on 15/08/18.
//  Copyright © 2018 Claudio Facchinetti. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var chechBox: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchDidChangeStatus(_ sender: UISwitch) {
        
        SettingsViewController.options[self.lblText.text!] = sender.isOn
        
    }
    
}
