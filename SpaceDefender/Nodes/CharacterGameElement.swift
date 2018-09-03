//
//  Character.swift
//  SpaceDefender
//
//  Created by Claudio Facchinetti on 26/07/18.
//  Copyright © 2018 Claudio Facchinetti. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class CharacterGameElement: GameElement {

    internal static var defaultMovementPixelPerSecond: CGFloat = 100
    internal static var defaultHitPoints: UInt = 10
    
    private(set) var hitPoints: Int
    public var movementPixelPerSecond: CGFloat
    
    public var actionsDelegate: ActionDelegate?
    
    public var movementPixelPerTick: CGFloat{
        
        return self.movementPixelPerSecond / 30
        
    }
    
    
    var alive: Bool{
        
        return self.hitPoints > 0
        
    }
    
    init( texture: SKTexture?, color: UIColor, size: CGSize, hitPoints: UInt, movementPixelPerSecond: CGFloat ){
        
        self.hitPoints = Int(hitPoints)
        self.movementPixelPerSecond = movementPixelPerSecond
       
        super.init(texture: texture, color: color, size: size)
        self.zPosition = 0
        self.anchorPoint = .zero
        
    }
    
    init(texture: SKTexture){
        
        self.hitPoints = Int(CharacterGameElement.defaultHitPoints)
        self.movementPixelPerSecond = CharacterGameElement.defaultMovementPixelPerSecond
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.zPosition = 0
        self.anchorPoint = .zero
        
    }
    
     init( texture: SKTexture, hitPoints: UInt, movementPixelPerSecond: CGFloat){
    
        self.hitPoints = Int(hitPoints)
        self.movementPixelPerSecond = movementPixelPerSecond
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.zPosition = 0
        self.anchorPoint = .zero
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    public func hit() throws{
        
        self.hitPoints -= 1
        if( self.hitPoints <= 0 ){
            
            do{
                try self.actionsDelegate?.nodeDied(self)
            } catch {
                
                throw error
                
            }
            
        }
        
    }
    
    public func move( withOffsetX offsetX: CGFloat, withOffsetY offsetY: CGFloat ){
        
        let newX = self.position.x + offsetX
        let newY = self.position.y + offsetY
        
        self.move(to: CGPoint(x: newX, y: newY))
        
        
    }
    
    public func move( to point: CGPoint ){
        
        if let scene = self.parent?.scene{
            let validX: Bool = point.x >= 0 && point.x <= scene.size.width - self.size.width
            let validY: Bool = point.y >= 0 && point.y <= scene.size.height - self.size.height
            
            if validX && validY{
                let distanceX = self.position.x - point.x
                let distanceY = self.position.y - point.y
                let distance = sqrt( distanceY * distanceY + distanceX * distanceX )
                let interval = TimeInterval(distance/self.movementPixelPerSecond)
                self.run(SKAction.move(to: point, duration: interval))
            }
            
        }
    }
    
    public func doDefaultAction() throws{
        
        do{
            try self.actionsDelegate?.automaticMoveOf(self)
        } catch {
            throw error
        }
        
    }
    
}
