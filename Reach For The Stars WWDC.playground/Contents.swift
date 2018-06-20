/*:
 ## 🌟Reach For The Stars🌟
 
 ### The Goal
 Capture the **smiling star** with your rocket.
 
 ### How To Play
 **Press and hold** the red button to generate thrust and move the rocket forward. **Release** it to let the rocket move by inertia.
 
 Planets will affect the rocket trajectory with their **gravitational** fields. To rotate the rocket, you will have to take advantage of gravity.
 
 You can press and release the button as many times as you need during a level.
 
 ### Note
 
 This Playground is intended to be played in **landscape mode** with the actual game occupying **half** of the iPad screen.
 
 ### Art Credits
 
 The **background music** was composed by me with GarageBand. The **smiling star**, the **red button** and the **animations** (explosions, starfield in the background, rocket fire, gravity field visualization and more) were designed by me.
 
 The **rocket** and **audio effects** are public domain. The **planets** are downloaded from vecteezy.com and licensed for free commercial and personal use.
 */

import PlaygroundSupport
import SpriteKit

let sceneView = SpaceView(frame: CGRect(x:0 , y:0, width: 480, height: 640))

sceneView.PlayBackgroundMusic()

if let scene = GameScene0(fileNamed: "GameScene") {
    scene.scaleMode = .aspectFill
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
