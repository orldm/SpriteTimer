//
//  GameScene.swift
//  SpriteTimer
//
//  Created by Dmitri Orlov on 12/23/14.
//  Copyright (c) 2014 Bullet. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        backgroundColor = UIColor.blackColor()
        
        let timer = TimerNode(dialRadius: 100)
        timer.position = CGPoint(x: 100, y: 100)
        addChild(timer)
    }
    
    
//    func updateDialPath(angle: CGFloat) {
//        let path = UIBezierPath(arcCenter: arcCenter, radius: dialRadius/2.0, startAngle: angle + CGFloat(M_PI/2), endAngle: CGFloat(M_PI/2.0), clockwise: true).CGPath
//        dialNode.path = path
//    }
//    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        /* Called when a touch begins */
//        
//        for touch: AnyObject in touches {
//            let location = touch.locationInNode(lineNode)
//            if handleNode.containsPoint(location) {
//                
//                settingIsEnabled = true
//                clockIsSet = false
//
//            }
//        }
//    }
//    
//    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
//        
//        if settingIsEnabled {
//        for touch: AnyObject in touches {
//            let location = touch.locationInNode(self)
//            
//                let moveArm = SKAction.reachTo(location, rootNode: lineNode, duration: 0.1)
//                handleNode.runAction(moveArm, completion: {
//                    self.angle = (Double(-self.lineNode.zRotation)/M_PI * 30)%60
//                    if self.angle < 0 { self.angle = 60 + self.angle }
//                    self.myLabel.text = "\(Int(self.angle))"
//                    self.secondsCount = Int(self.angle)
//                    let clockAngle = -CGFloat(self.secondsCount)*CGFloat(M_PI)/30
//                    self.updateDialPath(clockAngle)
//                })
//            
//        }
//        }
//    }
//    
//    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
//        settingIsEnabled = false
//        clockIsSet = true
//    }
//    
//    override func update(currentTime: CFTimeInterval) {
//        
//        if clockIsSet {
//            if let timeInterval = timeInterval {
//                elapsedTime += currentTime - timeInterval
//            }
//            timeInterval = currentTime
//            
//            if elapsedTime > 0 && !tickHappened {
//                let clockAngle = -CGFloat(secondsCount)*CGFloat(M_PI)/30
//                lineNode.runAction(SKAction.rotateToAngle(clockAngle, duration: 1.0, shortestUnitArc: true))
//                updateDialPath(clockAngle)
//                tickHappened = true
//            }
//            
//            if elapsedTime >= 1.0 {
//                elapsedTime = 0.0
//                tickHappened = false
//                if secondsCount == 0 {
//                    myLabel.text = "0"
//                    clockIsSet = false
//                } else {
//                    secondsCount -= 1
//                    myLabel.text = String(secondsCount+1)
//                }
//                
//            }
//        }
//    }
}
