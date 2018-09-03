//
//  ShuttleSKSpriteNode.swift
//  SpaceDefender
//
//  Created by Claudio Facchinetti on 26/07/18.
//  Copyright � 2018 Claudio Facchinetti. All rights reserved.
//

import UIKit
import SpriteKit

class ShuttleCharacter: CharacterGameElement {
    
    static let shuttleTexture: String = "shuttle"
    static let movePixelPerSecond: CGFloat = 300
    static let defualtInitialHitPoints: UInt = 10
    
    private(set) var invulnerable: Bool = false
    
    private(set) weak var shootTimer: Timer!
    
    public var bulletType: BulletType = .simple
    
    public var bullet: BulletCharacter{
        
        return BulletCharacter( type: self.bulletType )
        
    }
    
    init(){
        
        
        let texture = SKTexture(imageNamed: ShuttleCharacter.shuttleTexture)
        super.init(texture: texture , color: UIColor.clear, size: texture.size(), hitPoints: ShuttleCharacter.defualtInitialHitPoints, movementPixelPerSecond: ShuttleCharacter.movePixelPerSecond)
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.texture!.size())
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.categoryBitMask = BodyTypes.player.rawValue
        self.physicsBody?.collisionBitMask = BodyTypes.alien.rawValue
        self.physicsBody?.contactTestBitMask = BodyTypes.alien.rawValue
        self.shootTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            
            var bullets: [BulletCharacter] = [BulletCharacter]()
            switch self.bulletType{
                
            case .triple:
                print("Creato triple")
                let bullet: BulletCharacter = self.bullet
                bullet.position.x = self.position.x + self.size.width/2 - bullet.size.width / 2
                bullet.position.y = self.position.y + self.size.height + 40
                bullets.append(bullet)
                let bullet1 = BulletCharacter(type: self.bulletType)
                bullet1.position.x = self.position.x - bullet1.size.width / 2.0
                bullet1.position.y = self.position.y + self.size.height + 20
                bullets.append(bullet1)
                let bullet3 = BulletCharacter( type: self.bulletType )
                bullet3.position.x = self.position.x + self.size.width - bullet3.size.width/2.0
                bullet3.position.y = self.position.y + self.size.height + 20
                bullets.append(bullet3)
                
            case .simple:
                
                let bullet: BulletCharacter = self.bullet
                bullet.position.x = self.position.x + self.size.width/2 - bullet.size.width/2
                bullet.position.y = self.position.y + self.size.height + 20
                bullets.append(bullet)
            
                
            case .double:
                
                let bullet = BulletCharacter(type: self.bulletType)
                bullet.position.x = self.position.x - bullet.size.width / 2.0
                bullet.position.y = self.position.y + self.size.height + 40
                bullets.append(bullet)
                let bullet2 = BulletCharacter( type: self.bulletType )
                bullet2.position.x = self.position.x + self.size.width - bullet.size.width/2
                bullet2.position.y = self.position.y + self.size.height + 40
                bullets.append(bullet2)
            
           
            }
            
            if SettingsViewController.options[SettingsViewController.fxEffectsOption]!{
                
                self.run(SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: false))
                
            }
            
            for bullet in bullets{
                
                self.parent?.addChild(bullet)
                
            }
            
        })
        self.actionsDelegate = self
        
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


extension ShuttleCharacter: ActionDelegate{
    
    func automaticMoveOf(_ node: SKSpriteNode) throws {
        
        return
        
    }
    
    func nodeDied(_ node: SKSpriteNode) throws {
        
        throw GameOverError()
        
    }
    
}
