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
    var handleNode: SKShapeNode!
    var dialNode: SKShapeNode!
    var angle: Double = 0 //CGFloat(M_PI/30.0)
    let myLabel = SKLabelNode(fontNamed:"Helvetica")
    var secondsCount: Int = 0
    var tickHappened = false
    var clockIsSet = false
    var settingIsEnabled = false
    var dialRadius: CGFloat = 0
    var arcCenter = CGPoint(x: 0, y: 0)
    
    override func didMoveToView(view: SKView) {
        
        backgroundColor = UIColor.blackColor()
        
        dialRadius = min(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        arcCenter = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        let backDial = SKShapeNode(circleOfRadius: dialRadius/2.0)
        backDial.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        backDial.fillColor = SKColor.clearColor()
        backDial.strokeColor = SKColor.darkGrayColor()
        addChild(backDial)
        
        let path = UIBezierPath(arcCenter: arcCenter, radius: dialRadius/2.0, startAngle: CGFloat(M_PI/2.0), endAngle: CGFloat(M_PI/2.0), clockwise: true).CGPath
        
        dialNode = SKShapeNode(path: path)
        dialNode.strokeColor = SKColor.whiteColor()
        dialNode.lineWidth = 4.0
        //dialNode.glowWidth = 4.0
        addChild(dialNode)
        
        
        myLabel.text = "0";
        myLabel.fontSize = 65;
        myLabel.color = UIColor.grayColor()
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(myLabel)
        
        lineNode.size = CGSize(width: 4.0, height: dialRadius/2.0 - 10)
        lineNode.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        lineNode.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        lineNode.color = SKColor.clearColor()
        addChild(lineNode)

        
        handleNode = SKShapeNode(circleOfRadius: 40)
        handleNode.position = CGPoint(x: 0, y: CGRectGetMidY(self.frame)/2.0 - 5)
        handleNode.fillColor = SKColor.whiteColor()
        handleNode.strokeColor = SKColor.whiteColor()
        //handleNode.glowWidth = 5.0
        lineNode.addChild(handleNode)
        
    }
    
    
    func updateDialPath(angle: CGFloat) {
        let path = UIBezierPath(arcCenter: arcCenter, radius: dialRadius/2.0, startAngle: angle + CGFloat(M_PI/2), endAngle: CGFloat(M_PI/2.0), clockwise: true).CGPath
        dialNode.path = path
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(lineNode)
            if handleNode.containsPoint(location) {
                
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
                handleNode.runAction(moveArm, completion: {
                    self.angle = (Double(-self.lineNode.zRotation)/M_PI * 30)%60
                    if self.angle < 0 { self.angle = 60 + self.angle }
                    self.myLabel.text = "\(Int(self.angle))"
                    self.secondsCount = Int(self.angle)
                    let clockAngle = -CGFloat(self.secondsCount)*CGFloat(M_PI)/30
                    self.updateDialPath(clockAngle)
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
            
            if elapsedTime > 0 && !tickHappened {
                let clockAngle = -CGFloat(secondsCount)*CGFloat(M_PI)/30
                lineNode.runAction(SKAction.rotateToAngle(clockAngle, duration: 1.0, shortestUnitArc: true))
                updateDialPath(clockAngle)
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
