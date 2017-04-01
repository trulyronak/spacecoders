import PlaygroundSupport
import SpriteKit

let game = SpaceCodersGame()

let sceneView = game.sceneView

let scene = game.scene
sceneView.showsFPS = true
sceneView.showsNodeCount = true
sceneView.presentScene(scene)
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

let player = game.player

game.everySecond {
    // write your code here!
    player.moveUp()
    player.fire()
}
