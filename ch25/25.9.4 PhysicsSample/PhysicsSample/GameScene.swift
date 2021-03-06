//
//  GameScene.swift
//  PhysicsSample
//
//  Created by 关东升 on 2017/1/20.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let spriteNames = ["orange", "drink", "hamburger", "hotdog", "icecream", "icecream2", "icecream3"]
    
    // 食品类别掩码
    let spriteCategory: UInt32 = 0x1 << 0 // 前28位是0，后四位是0001
    // 墙类别掩码
    let wallCategory: UInt32   = 0x1 << 1  // 前28位是0，后四位是0010
 
    override func didMove(to view: SKView) {
        
        //定义屏幕的边界
        let wall = SKPhysicsBody(edgeLoopFrom: view.frame)
        
        wall.categoryBitMask    =   wallCategory
        wall.collisionBitMask   =   0x0    //清除掩码，不发生碰撞
        wall.contactTestBitMask =   0x0    //清除掩码，不进行接触测试
        
        self.physicsBody = wall
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.8)
        self.physicsWorld.contactDelegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
        for touch in touches {

            let location = touch.location(in: self)
            let name = spriteNames[Int(arc4random() % 7)]
            let sprite = SKSpriteNode(imageNamed: name)
            sprite.name = name
            sprite.position = location
            
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            //sprite.physicsBody!.dynamic = false
            
            sprite.physicsBody?.categoryBitMask = spriteCategory
            sprite.physicsBody?.collisionBitMask = spriteCategory | wallCategory
            sprite.physicsBody?.contactTestBitMask = spriteCategory
            
            addChild(sprite)
            
        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        NSLog("didBeginContact")
        NSLog("NodeA = %@", contact.bodyA.node!)
        NSLog("NodeB = %@", contact.bodyB.node!)
    }
    
    
    func didEnd(_ contact: SKPhysicsContact) {
        NSLog("didEndContact")
    }
}
