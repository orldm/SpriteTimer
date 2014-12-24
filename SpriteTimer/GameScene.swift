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
    var angle: Double = 0 //CGFloat(M_PI/30.0)
    let myLabel = SKLabelNode(fontNamed:"Helvetica")
    var secondsCount: Int = 0
    var tickHappened = false
    var clockIsSet = false
    var settingIsEnabled = false
    
    override func didMoveToView(view: SKView) {
        
        //timeInterval = CF
        
        myLabel.text = "0";
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
            let location = touch.locationInNode(lineNode)
            if squareNode.containsPoint(location) {
                
                settingIsEnabled = true
                clockIsSet = false

            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        if settingIsEnabled {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
                let moveArm = SKAction.reachTo(location, rootNode: lineNode, duration: 0.1)
                squareNode.runAction(moveArm, completion: {
                    self.angle = (Double(-self.lineNode.zRotation)/M_PI * 30)%60
                    if self.angle < 0 { self.angle = 60 + self.angle }
                    self.myLabel.text = "\(Int(self.angle))"
                    self.secondsCount = Int(self.angle)
                })
            
        }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        settingIsEnabled = false
        clockIsSet = true
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        if clockIsSet {
            if let timeInterval = timeInterval {
                elapsedTime += currentTime - timeInterval
            }
            timeInterval = currentTime
            
            if elapsedTime >= 0.9 && !tickHappened {
                let clockAngle = -CGFloat(secondsCount)*CGFloat(M_PI)/30
                lineNode.runAction(SKAction.rotateToAngle(clockAngle, duration: 0.1, shortestUnitArc: true))
                tickHappened = true
            }
            
            if elapsedTime >= 1.0 {
                elapsedTime = 0.0
                tickHappened = false
                if secondsCount == 0 {
                    myLabel.text = "0"
                    clockIsSet = false
                } else {
                    secondsCount -= 1
                    myLabel.text = String(secondsCount+1)
                }
                
            }
        }
    }
}
