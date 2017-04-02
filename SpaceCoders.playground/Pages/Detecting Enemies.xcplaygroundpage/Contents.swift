//: [Back to Player Methods](@previous)
import PlaygroundSupport
import SpriteKit

let game = SpaceCodersGame()
let player = game.player
/*:
 Using the ```game``` object, we can actually get the next spawn location of our enemy
 
 ### Game Object
 - ```game.nextSpawnLocation``` - Returns the next spawn location of an enemy
 */
game.everySecond {
    // write code here
    let nextLocation = game.nextSpawnLocation
    // now, we can use the player's location to find out where to go!
    player.fire()
}
//: [But what exactly is a 'location' in SpaceCoders?](@next)
func startGame() {
    let sceneView = game.sceneView
    
    let scene = game.scene
    sceneView.showsFPS = true
    sceneView.showsNodeCount = true
    sceneView.presentScene(scene)
    PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
}
startGame()
