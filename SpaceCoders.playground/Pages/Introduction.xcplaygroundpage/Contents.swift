/*
  ____                          ____          _
 / ___| _ __   __ _  ___ ___   / ___|___   __| | ___ _ __ ___
 \___ \| '_ \ / _` |/ __/ _ \ | |   / _ \ / _` |/ _ \ '__/ __|
  ___) | |_) | (_| | (_|  __/ | |__| (_) | (_| |  __/ |  \__ \
 |____/| .__/ \__,_|\___\___|  \____\___/ \__,_|\___|_|  |___/
       |_|
 
*/
/*: 
 ### DISCLAIMER:
    
 This tutorial is meant for people who have basic programming
    experience, and understand if else statements, variables, and
    calling methods.
 */
/*: ## Goal of the Game

 In Space Coders, the goal of the game is to write code to move your ship around to automatically destroy the enemies.
 
 
 */
//: [Learn how to control the player](@next)
import PlaygroundSupport
import SpriteKit

let game = SpaceCodersGame()
let player = game.player


game.everySecond {
    // You'll Be Writing Code to Control the Player Here!
    player.fire()
}
func startGame() {
    let sceneView = game.sceneView
    
    let scene = game.scene
    sceneView.showsFPS = true
    sceneView.showsNodeCount = true
    sceneView.presentScene(scene)
    PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
}
startGame()
