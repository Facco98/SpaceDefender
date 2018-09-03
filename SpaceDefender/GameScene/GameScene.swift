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
    case deadAlien = 4
    
}

class GameScene: SKScene {
    
    var shuttle: ShuttleCharacter = ShuttleCharacter()

    private(set) var score: Int = 0
    private(set) var killingSpree: Int = 0
    private(set) weak var spawnTimer: Timer!
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = .zero
        self.physicsWorld.contactDelegate = self
        self.addChild(self.shuttle)
        
        self.spawnTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            var type: AlienTypes = .type3
            let random = arc4random_uniform(100)
            
            for key in AlienTypes.probabilties.keys{
                
                let probs = AlienTypes.probabilties[key]!
                if key.contains(self.score){
                    
                    if random <= Int(probs["type1"]!){
                        
                        type = .type1
                        
                    } else if random <= Int(probs["type2"]!){
                        
                        type = .type2
                        
                    } else {
                        
                        type = .type3
                        
                    }
                    
                }
                
            }
            
            let alien = AlienCharacter(type: type)
            alien.position.x = CGFloat(arc4random_uniform(UInt32(self.size.width - alien.size.width)))
            alien.position.y = self.size.height - alien.size.height - 10
            alien.movementPixelPerSecond += CGFloat(Double(self.score) / exp(Double(self.killingSpree)))
            self.addChild(alien)
            
        }
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        for node in self.children{
            
            if let node = node as? CharacterGameElement{
                do{
                try node.doDefaultAction()
                } catch {
                    
                    if let _ = error as? AlienExitedScreenError {
                        
                        do{
                            
                            try self.shuttle.hit()
                            self.killingSpree = 0
                            self.shuttle.bulletType = .simple
                        } catch{
                            
                            if let _ = error as? GameOverError{
                                
                                self.gameOver()
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
    }
    
    private func gameOver(){
        
        if let timer = self.spawnTimer{
            
            timer.invalidate()
            
        }
        
        if let timer = self.shuttle.shootTimer{
            
            timer.invalidate()
            
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
        
        /*
        let isPlayerInvolved = contact.bodyA.categoryBitMask == BodyTypes.player.rawValue || contact.bodyB.categoryBitMask == BodyTypes.player.rawValue
        let isAlienInvolved = contact.bodyA.categoryBitMask == BodyTypes.alien.rawValue || contact.bodyB.categoryBitMask == BodyTypes.alien.rawValue
        let isBulletInvolved = (contact.bodyA.categoryBitMask == BodyTypes.bullet.rawValue || contact.bodyB.categoryBitMask == BodyTypes.bullet.rawValue)
         */
        
        for node in [contact.bodyA.node, contact.bodyB.node]{
            
            if let node = node as? CharacterGameElement{
                
                do{
                    try node.hit()
                    if let _ = node as? ShuttleCharacter{
                        
                        self.killingSpree = 0
                        self.shuttle.bulletType = .simple

                    } else{
                        
                        self.killingSpree += 1
                        self.score += 1
                        if self.killingSpree >= BulletType.tripleLimit{
                            
                            self.shuttle.bulletType = .triple
                            
                        } else if self.killingSpree >= BulletType.doubleLimit{
                            
                            self.shuttle.bulletType = .double
                            
                        }
                    }
                } catch{
                    
                    if let _ = error as? GameOverError{
                        
                        self.gameOver()
                        
                    }
                    
                }
            }
            
        }
        
    }
    
    public func didEnd(_ contact: SKPhysicsContact){
        
    }
    
    
}
