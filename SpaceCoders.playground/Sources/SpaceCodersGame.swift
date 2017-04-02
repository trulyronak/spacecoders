import Foundation
import SpriteKit

public class SpaceCodersGame {
    public var sceneView: SKView
    public var scene: GameScene
    public var player: Player
    
    public var onClick: (() ->())!
    
    public var nextSpawnLocation: Int {
        get {
            return nextEnemyLocation
        }
        set(new) {
            self.nextSpawnLocation = new
        }
    }
    //options: 0,1,2,3,4
    var spawners:[SKSpriteNode] = []
    
    public init() {
        sceneView = SKView(frame: CGRect(x:0 , y:0, width: 600, height: 800))
        
        scene = GameScene(size: CGSize(width: 600, height: 800))
        //sceneView.showsFPS = true
        sceneView.presentScene(scene)
        
        
        
        // setup scene
        
        // base locations for all nodes
        let locs:[CGPoint] = [
            CGPoint(x: scene.size.width - 25, y: 730),
            CGPoint(x: scene.size.width - 25, y: 570),
            CGPoint(x: scene.size.width - 25, y: 410),
            CGPoint(x: scene.size.width - 25, y: 250),
            CGPoint(x: scene.size.width - 25, y: 90)
        ]
        
        // create a ship
        player = Player(imageNamed: "ship.png")
        player.name = "player"
        player.referenceLocs = locs
        player.size = CGSize(width: 50, height: 50)
        player.position = CGPoint(x: 25, y: locs[2].y)
        player.zRotation = CGFloat(-Double.pi/2)
        // physics
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = PhysicsCategory.Ship //seting the player's bit mask
        player.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy // What collisions should I worry about
        player.physicsBody?.collisionBitMask = PhysicsCategory.None // What objects SpriteKit should run physics on -> none


        
        scene.addChild(player)
        
        // create spawners
        
        
        for loc in locs {
            let spawner = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 50, height: 50))
            spawner.name = "spawner"
            spawner.size = CGSize(width: 50, height: 50)
            spawner.position = loc
            
            
            
            scene.addChild(spawner)
            spawners.append(spawner)
        }
    
        
        scene.spawnCode = {
            
            let spawnEnemyAction = SKAction.run {
                let enemy = SKSpriteNode(imageNamed: "enemy.png")
                enemy.name = "enemy"
                enemy.size = CGSize(width: 50, height: 50)
                enemy.position = self.spawners[self.nextSpawnLocation].position
                // physics 
                enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
                enemy.physicsBody?.isDynamic = true
                enemy.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
                enemy.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet | PhysicsCategory.Ship
                enemy.physicsBody?.collisionBitMask = PhysicsCategory.None
                enemy.physicsBody?.usesPreciseCollisionDetection = true
                
                
                let moveForward = SKAction.move(to: CGPoint(x: 0 , y: enemy.position.y), duration: 4)
                let endGame = SKAction.run {
                    // this code runs if enemy reached other side
                    // thus, game is over
                    //print("You Lose! :( ")
                    let explosion = SKSpriteNode(imageNamed: "explosion.png")
                    explosion.size = enemy.size
                    explosion.position = enemy.position
                    explosion.run(SKAction.sequence([SKAction.fadeOut(withDuration: 2), SKAction.removeFromParent()]))
                    self.scene.addChild(explosion)
                    print("You Lose :(")
                }
                enemy.run(SKAction.sequence([moveForward, endGame, SKAction.removeFromParent()]))
                self.scene.addChild(enemy)
                
            }
            self.spawners[self.nextSpawnLocation].run(spawnEnemyAction)
        }
     
    }
    
    
    public func everySecond(code:@escaping (()->())) {
        self.scene.everySecond = code
    }
  
    
}
