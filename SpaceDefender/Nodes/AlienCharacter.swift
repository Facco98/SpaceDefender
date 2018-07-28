//
//  File.swift
//  SpaceDefender
//
//  Created by Claudio Facchinetti on 26/07/18.
//  Copyright © 2018 Claudio Facchinetti. All rights reserved.
//

import Foundation
import SpriteKit

class AlienCharacter: CharacterGameElement{
    
    public static let selfTextures: [String] = ["alien", "alien2", "alien3"]
    public static let defaultAlienMovementPixelPerSecond: [CGFloat] = [100, 150, 200]
    public static let defaultAlienHitPoints: [UInt] = [1,2,3]
    

    
    init(type: AlienTypes){
        
        let txt = AlienCharacter.selfTextures[type.rawValue]
        let hitPoints = AlienCharacter.defaultAlienHitPoints[type.rawValue]
        let movSpeed = AlienCharacter.defaultAlienMovementPixelPerSecond[type.rawValue]
        
        super.init(texture: SKTexture(imageNamed: txt), hitPoints: hitPoints, movementPixelPerSecond: movSpeed)
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.texture!.size())
        self.physicsBody?.categoryBitMask = BodyTypes.alien.rawValue
        self.physicsBody?.collisionBitMask = BodyTypes.bullet.rawValue | BodyTypes.player.rawValue
        self.physicsBody?.contactTestBitMask = BodyTypes.bullet.rawValue | BodyTypes.player.rawValue
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.actionsDelegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }
    
    
    deinit{
        
        
        
    }
}


extension AlienCharacter: ActionDelegate{
    func automaticMoveOf(_ node: SKSpriteNode) {
        
        let node = node as! AlienCharacter
        let offsetY = node.movementPixelPerTick  * (-1)
        if self.position.y + offsetY < 0 {
            
            self.removeFromParent()
            
        } else{
            
            self.move(withOffsetX: 0, withOffsetY: offsetY)
            
        }
        
    }
    
    
    
    
}
