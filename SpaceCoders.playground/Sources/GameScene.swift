import SpriteKit

public class GameScene: SKScene, SKPhysicsContactDelegate {

    public var everySecond: (() ->()) = {print("pls")}
    public var spawnCode: (() ->()) = {print("spawning")}
    
    private var count = 0
    var spawners:[SKSpriteNode] = []
    var generatedRandom = false
    
    override public init(size: CGSize) {
        super.init(size: size)
        self.physicsWorld.gravity = CGVector.zero
        self.physicsWorld.contactDelegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // collisions
    public func didBegin(_ contact: SKPhysicsContact) {
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.Enemy != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Bullet != 0)) {
            if let enemy = firstBody.node as? SKSpriteNode, let
                bullet = secondBody.node as? SKSpriteNode {
                self.collision(a: bullet, b: enemy)            }
        }
        
    }
    
    func collision(a: SKSpriteNode, b: SKSpriteNode) {
        if (a.className == "Player") {
            if (b.name == "bullet") {return}
            let player = a as! Player
            // game over
            //player.removeFromParent()
            b.removeFromParent()
            print("You Lose :(")
            createExplosion(atPoint: player.position)
            gameOver()
        }
        else if (b.className == "Player") {
            if (a.name == "bullet") {return}
            let player = b as! Player
            // game over
            //player.removeFromParent()
            a.removeFromParent()
            print("You Lose :(")
            createExplosion(atPoint: player.position)
            gameOver()
        }
        else { // its a bullet and an enemy
            a.removeFromParent()
            b.removeFromParent()
            //print("You destroyed an enemy!")
            createExplosion(atPoint: b.position)
        }
    }
    func gameOver() {
        let text = SKLabelNode(text: "Game Over")
        text.color = UIColor.white
    
        text.position = CGPoint(x: (self.scene?.size.width)! / 2, y: (self.scene?.size.height)! / 2)
        self.addChild(text)
    }
    func createExplosion(atPoint: CGPoint) {
        let explosion = SKSpriteNode(imageNamed: "explosion.png")
        explosion.size = CGSize(width: 100, height: 100)
        explosion.position = atPoint
        explosion.run(SKAction.sequence([SKAction.fadeOut(withDuration: 2), SKAction.removeFromParent()]))
        self.addChild(explosion)
    }
    override public func update(_ currentTime: TimeInterval) {
        count += 1
        if (!generatedRandom) {
            nextEnemyLocation = Int.random(start: 0, end: 4)
            generatedRandom = true
        }
        if ((count % 40) == 0) {
            self.everySecond()
            
        }
        if ((count % 200) == 0) {
            self.spawnCode()
            generatedRandom = false
        }
    }
}
