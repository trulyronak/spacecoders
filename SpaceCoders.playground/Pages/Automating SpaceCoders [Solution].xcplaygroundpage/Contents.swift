//: [Back to Coding](@previous)
import PlaygroundSupport
import SpriteKit

let game = SpaceCodersGame()
let player = game.player
/*:
 # Solution
 */

game.everySecond {
    // write code here
    let playerLoc = player.location
    let enemyLoc = game.nextSpawnLocation

    if (playerLoc > enemyLoc) {
        player.moveUp()
    }
    else {
        player.moveDown()
    }
    player.fire()
}
//: [Credits](@next)

func startGame() {
    let sceneView = game.sceneView
    
    let scene = game.scene
    sceneView.showsFPS = true
    sceneView.showsNodeCount = true
    sceneView.presentScene(scene)
    PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
}
startGame()