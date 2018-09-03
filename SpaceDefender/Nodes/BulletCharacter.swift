//
//  BulletCharacter.swift
//  SpaceDefender
//
//  Created by Claudio Facchinetti on 28/07/18.
//  Copyright © 2018 Claudio Facchinetti. All rights reserved.
//

import UIKit
import SpriteKit

class BulletCharacter: CharacterGameElement {

    static let defaultBulletMovementSpeed: [CGFloat] = [100,150,200]
    static let defaultBulletTexture: String = "torpedo"
    static let defualtTimerShoot: [TimeInterval] = [1, 0.8, 0.6]
    init(type: BulletType){
        

        let movSpeed = BulletCharacter.defaultBulletMovementSpeed[type.rawValue]
        let texture = SKTexture(imageNamed: BulletCharacter.defaultBulletTexture)
        super.init(texture: texture, hitPoints: 1, movementPixelPerSecond: movSpeed)
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = BodyTypes.bullet.rawValue
        self.physicsBody?.collisionBitMask = BodyTypes.alien.rawValue | BodyTypes.player.rawValue
        self.physicsBody?.contactTestBitMask = BodyTypes.alien.rawValue | BodyTypes.player.rawValue
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.actionsDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension BulletCharacter: ActionDelegate{
    
    func automaticMoveOf(_ node: SKSpriteNode) {
        let node = node as! BulletCharacter
        let offsetY = node.movementPixelPerTick
        let validX: Bool = self.position.x >= 0 && self.position.x <= (self.scene?.size.width)! - self.size.width
        
        if !validX || node.position.y + offsetY >= (node.scene?.size.height)! - self.size.height{
            
            node.removeFromParent()
            
        } else{
            
            node.move(withOffsetX: 0, withOffsetY: offsetY)
            
        }
    }
    
    func nodeDied(_ node: SKSpriteNode) {
        print("Bullet died")
        node.removeFromParent()
    }
    
    
    
    
}
