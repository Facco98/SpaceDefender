//
//  ActionDelegate.swift
//  SpaceDefender
//
//  Created by Claudio Facchinetti on 28/07/18.
//  Copyright © 2018 Claudio Facchinetti. All rights reserved.
//

import Foundation
import SpriteKit

public protocol ActionDelegate{
    
    func automaticMoveOf(_ node: SKSpriteNode)
    
}
