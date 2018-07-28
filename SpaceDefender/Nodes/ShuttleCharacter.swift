//
//  ShuttleSKSpriteNode.swift
//  SpaceDefender
//
//  Created by Claudio Facchinetti on 26/07/18.
//  Copyright © 2018 Claudio Facchinetti. All rights reserved.
//

import UIKit
import SpriteKit

class ShuttleCharacter: CharacterGameElement {
    
    static let shuttleTexture: SKTexture = SKTexture(imageNamed: "shuttle")
    static let movePixelPerSecond: CGFloat = 300
    static let defualtInitialHitPoints: UInt = 10
    
    private(set) var invulnerable: Bool = false
    
    private(set) weak var shootTimer: Timer!
    
    init(){
        
        
        super.init(texture: ShuttleCharacter.shuttleTexture, color: UIColor.clear, size: ShuttleCharacter.shuttleTexture.size(), hitPoints: ShuttleCharacter.defualtInitialHitPoints, movementPixelPerSecond: ShuttleCharacter.movePixelPerSecond)
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.texture!.size())
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.categoryBitMask = BodyTypes.player.rawValue
        //self.physicsBody?.collisionBitMask = BodyTypes.alien.rawValue
        //self.physicsBody?.contactTestBitMask = BodyTypes.alien.rawValue
        self.shootTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            
            let bullet: BulletCharacter = BulletCharacter(type: .simple)
            bullet.position.x = self.position.x + self.size.width/2
            bullet.position.y = self.position.y + self.size.height/2 + 100
            self.parent?.addChild(bullet)
            
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func hit() throws{
        
        if !self.invulnerable {
            
            do{
                try super.hit()
                self.invulnerable = true
                self.alpha = 0.5
                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
                    self.invulnerable = false
                    self.alpha = 1
                })
            } catch{
                
                throw error
                
            }
            
        }
        
    }
    
    
}