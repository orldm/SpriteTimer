//
//  GameScene.swift
//  SpriteTimer
//
//  Created by Dmitri Orlov on 12/23/14.
//  Copyright (c) 2014 Bullet. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var elapsedTime: CFTimeInterval = 0.0
    var timeInterval: CFTimeInterval?
    let lineNode = SKSpriteNode()
    let squareNode = SKSpriteNode()
    let angle = CGFloat(-M_PI/30.0)
    let myLabel = SKLabelNode(fontNamed:"Helvetica")
    var secondsCount = 0
    var tickHappened = false
    
    override func didMoveToView(view: SKView) {
        
        //timeInterval = CF
        
        myLabel.text = "00";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(myLabel)
        
        lineNode.size = CGSize(width: 4.0, height: CGRectGetMidY(self.frame)/2.0 - 10)
        lineNode.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        lineNode.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        lineNode.color = SKColor.blueColor()
        addChild(lineNode)
        
        squareNode.size = CGSize(width: 60, height: 60)
        squareNode.position = CGPoint(x: 0, y: CGRectGetMidY(self.frame)/2.0 - 10)
        squareNode.color = SKColor.blueColor()
        lineNode.addChild(squareNode)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
        }
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        
        if let timeInterval = timeInterval {
            elapsedTime += currentTime - timeInterval
        }
        timeInterval = currentTime
        
        if elapsedTime >= 0.9 && !tickHappened {
            lineNode.runAction(SKAction.rotateByAngle(angle, duration: 0.1))
            tickHappened = true
        }
        
        if elapsedTime >= 1.0 {
            elapsedTime = 0.0
            tickHappened = false
            if secondsCount == 59 {
                secondsCount = 0
            } else {
                secondsCount += 1
            }
            
            myLabel.text = String(secondsCount)
            
        }
    }
}
