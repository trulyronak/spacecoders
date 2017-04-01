import Foundation
import SpriteKit

public class Player: SKSpriteNode {
    
    public var loc: Int = 2
    public var referenceLocs: [CGPoint]!
    public var moving = false
    
    public func moveUp() {
        /*
        Check if player can move up
        if it can't, don't move up
        if it can, move up
        */
        if (loc == 0) {
            //can't move anymore
        }
        else if (!moving) {
            loc -= 1
            let move = SKAction.moveTo(y: referenceLocs[loc].y, duration: 1)
            self.run(SKAction.sequence([move, SKAction.run {
                self.moving = false
                }]))
            self.moving = true
        }
    }
    
    public func moveDown() {
        if (loc == 4) {
            //can't move anymore
        }
        else if (!moving) {
            loc += 1
            let move = SKAction.moveTo(y: referenceLocs[loc].y, duration: 1)
            self.run(SKAction.sequence([move, SKAction.run {
                self.moving = false
                }]))
            self.moving = true
        }
        /*
         Check if player can move down
         if it can't, don't move down
         if it can, move down
         */
    }
    
    public func fire() {
        
        let bullet = SKSpriteNode(imageNamed: "bullet.png")
        bullet.size = CGSize(width: 10, height: 10)
        bullet.position = self.position
        bullet.name = "bullet"
        // physics
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody?.isDynamic = true
        bullet.physicsBody?.categoryBitMask = PhysicsCategory.Bullet
        bullet.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        bullet.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        
        let moveForward = SKAction.moveTo(x: scene!.size.width, duration: 4)
        
        
        let actions = SKAction.group([SKAction.sequence([moveForward, SKAction.removeFromParent()])])
        bullet.run(actions)
        scene?.addChild(bullet)
        bullets.append(bullet)
        /*
         Create bullet sprite
         create bullet actions
         create collision handler
         add bullet to scene at location of player
         */
        
    }
}
