//: [Back to Introduction](@previous)
import PlaygroundSupport
import SpriteKit

let game = SpaceCodersGame()
let player = game.player
/*:
 To control the player, we'll be using the following methods / variables
 
 
 ### Player Object
 - ```player.fire()``` - Shoots a bullet at the enemy
 - ```player.moveUp()``` - Moves up one block
 - ```player.moveDown()``` - Moves down one block
 - ```player.location``` - Gets current location
 
*/
game.everySecond {
/*:
 Here, we'll be using those methods. Try it out for yourself by making the player move up and shoot the enemies!
*/
    // write code here
    player.fire()
    player.moveDown()
}
//: [Learn how to detect where enemies will spawn](@next)
func startGame() {
    let sceneView = game.sceneView
    
    let scene = game.scene
    sceneView.showsFPS = true
    sceneView.showsNodeCount = true
    sceneView.presentScene(scene)
    PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
}
startGame()
