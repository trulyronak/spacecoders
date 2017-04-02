//: [Back to Explaining Locations](@previous)
import PlaygroundSupport
import SpriteKit

let game = SpaceCodersGame()
let player = game.player
/*:
 Now that we understand the location system, we can get to work on writing an automation program. Below, I've included some pseudocode on how to do it.
 */
game.everySecond {
    // write code here
    
    //Get Player Location
    //Get Spawned Enemy's Location
    //if (playerLoc > enemyLoc)
    //	move down
    //else
    //	move up
    //
    //fire bullets
}
//: [View Solution](@next)

func startGame() {
    let sceneView = game.sceneView
    
    let scene = game.scene
    sceneView.showsFPS = true
    sceneView.showsNodeCount = true
    sceneView.presentScene(scene)
    PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
}
startGame()
