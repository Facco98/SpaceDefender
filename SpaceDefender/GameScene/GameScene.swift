//
//  GameScene.swift
//  SpaceDefender
//
//  Created by Claudio Facchinetti on 26/07/18.
//  Copyright © 2018 Claudio Facchinetti. All rights reserved.
//

import SpriteKit
import GameplayKit

enum BodyTypes: UInt32{
    
    case player = 1
    case alien = 2
    case bullet = 3
    
}

class GameScene: SKScene {
    
    var shuttle: ShuttleCharacter = ShuttleCharacter()
    private(set) var lblPunteggio: SKLabelNode = SKLabelNode(text: "Punteggio: 0")
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = .zero
        self.physicsWorld.contactDelegate = self
        self.addChild(self.shuttle)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            let alien = AlienCharacter(type: .type1)
            alien.position.x = CGFloat(arc4random_uniform(UInt32(self.size.width - alien.size.width)))
            alien.position.y = self.size.height - alien.size.height - 250
            self.addChild(alien)
            
        }
        
        self.lblPunteggio.horizontalAlignmentMode = .left
        self.lblPunteggio.verticalAlignmentMode = .top
        self.lblPunteggio.position.x = self.size.width / 2 * (-1)
        self.lblPunteggio.position.y = self.size.height / 2
        
        self.addChild(self.lblPunteggio)
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        for node in self.children{
            
            if let node = node as? CharacterGameElement{
                
                node.doDefaultAction()
                
            }
            
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
        
        self.shuttle.move(to: pos)
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        self.shuttle.move(to: pos)
        
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        self.shuttle.removeAllActions()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    
}


//MARK: Collision Detection
extension GameScene: SKPhysicsContactDelegate{
    
    public func didBegin(_ contact: SKPhysicsContact){
        
        let isPlayerInvolved = contact.bodyA.categoryBitMask == BodyTypes.player.rawValue || contact.bodyB.categoryBitMask == BodyTypes.player.rawValue
        let isAlienInvolved = contact.bodyA.categoryBitMask == BodyTypes.alien.rawValue || contact.bodyB.categoryBitMask == BodyTypes.alien.rawValue
        let isBulletInvolved = (contact.bodyA.categoryBitMask == BodyTypes.bullet.rawValue || contact.bodyB.categoryBitMask == BodyTypes.bullet.rawValue)
        
        if isPlayerInvolved {
            
            do{
                self.shuttle.removeAllActions()
                try self.shuttle.hit()

            } catch {
                
                print("GameOver")
                
            }
            
        }
        
        if isBulletInvolved{
            
            let bullet: BulletCharacter = (contact.bodyA.categoryBitMask == BodyTypes.bullet.rawValue) ? (contact.bodyA.node as! BulletCharacter) : (contact.bodyB.node as! BulletCharacter)
            
            do{
                try bullet.hit()
            } catch {
                
                bullet.removeFromParent()
                
            }
            
            
        }
        
        if( isAlienInvolved ){
        
            let alien: AlienCharacter = (contact.bodyA.categoryBitMask == BodyTypes.alien.rawValue) ? (contact.bodyA.node as! AlienCharacter) : (contact.bodyB.node as! AlienCharacter)
            
            do{
                
                try alien.hit()
                
            } catch {
                alien.removeFromParent()
            }
        }
        
        
    }
    
    public func didEnd(_ contact: SKPhysicsContact){
        
    }
    
    
}
