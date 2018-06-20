import SpriteKit
import PlaygroundSupport

public class GameScene2: GameScene {
    
    let planet1 = SKSpriteNode(imageNamed: "Planets/globe2")
    let visualGravity = SKEmitterNode(fileNamed:"Particles/VisualGravity2")
    
    override func resetScene () {
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        if let gameScene = GameScene2(fileNamed: "GameScene"){
            gameScene.scaleMode = .aspectFill
            self.view?.presentScene(gameScene, transition: reveal)
        }
    }
    
    override public func loadNextScene(size: CGSize){
        youWonScene = YouWonScene2(size: size)
        youWonScene.starCount = SKSpriteNode(imageNamed: "StarCounter/2:6stars")
    }
    
    override public func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        rocket.zRotation = -0.7
        
        planet1.setScale(0.6)
        planet1.physicsBody = SKPhysicsBody(circleOfRadius: planet1.size.height/2)
        planet1 .physicsBody?.isDynamic = false
        planet1.physicsBody?.categoryBitMask = PhysicsCategory.Planet
        planet1.physicsBody?.contactTestBitMask = PhysicsCategory.Rocket
        planet1.physicsBody?.collisionBitMask = PhysicsCategory.None
        planet1.physicsBody?.usesPreciseCollisionDetection = true
        planet1.addChild(gravity)

        rocket.position = CGPoint (x: -100, y: -245)
        addChild(rocket)
        planet1.position = CGPoint (x: -100, y: 50)
        addChild(planet1)
        star.position = CGPoint (x: 0, y: 250)
        addChild(star)
        
        visualGravity!.position = planet1.position
        addChild(visualGravity!)
    }
    
    override public func setGravity(){
        gravity.strength = 1.4
    }
}










