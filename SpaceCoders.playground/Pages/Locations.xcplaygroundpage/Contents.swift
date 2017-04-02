//: [Previous](@previous)

import Foundation

/*:
 ### Locations
 
 In Space Coders, the world is divded into 5 (vertical) locations
 
![Table View of World](reference.png)
 
 The enemies can spawn in any of the 5 locations, and the player has the ability to know where the enemy is going to spawn, by accessing the variable from ```game```.
 
 To get the next location, call ```game.nextSpawnLocation```
 
 We can get the player's current location by calling ```player.location```
 
 Given this information, we can write an AI that will automatically defeat our enemies!

 */
//: [Let's Start!](@next)
import PlaygroundSupport
import SpriteKit

let game = SpaceCodersGame()
let player = game.player

func startGame() {
    let sceneView = game.sceneView
    
    let scene = game.scene
    sceneView.showsFPS = true
    sceneView.showsNodeCount = true
    sceneView.presentScene(scene)
    PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
}
startGame()
