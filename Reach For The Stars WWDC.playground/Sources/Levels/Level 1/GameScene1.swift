import SpriteKit
import PlaygroundSupport

public class GameScene1: GameScene {

    let planet1 = SKSpriteNode(imageNamed: "Planets/globe1")
    let visualGravity = SKEmitterNode(fileNamed:"Particles/VisualGravity")
    
    override func resetScene(){
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        if let gameScene = GameScene1(fileNamed: "GameScene"){
            gameScene.scaleMode = .aspectFill
            self.view?.presentScene(gameScene, transition: reveal)
        }
    }
    
    override public func loadNextScene(size: CGSize){
        youWonScene = YouWonScene1(size: size)
        youWonScene.starCount = SKSpriteNode(imageNamed: "StarCounter/1:6stars")
    }
    
    override public func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        rocket.zRotation = 0.52
        
        planet1.setScale(0.75)
        planet1.physicsBody = SKPhysicsBody(circleOfRadius: planet1.size.height/2)
        planet1 .physicsBody?.isDynamic = false
        planet1.physicsBody?.categoryBitMask = PhysicsCategory.Planet
        planet1.physicsBody?.contactTestBitMask = PhysicsCategory.Rocket
        planet1.physicsBody?.collisionBitMask = PhysicsCategory.None
        planet1.physicsBody?.usesPreciseCollisionDetection = true
        planet1.addChild(gravity)
        
        rocket.position = CGPoint (x: -100, y: -245)
        addChild(rocket)
        planet1.position = CGPoint (x: 50, y: 0)
        addChild(planet1)
        star.position = CGPoint (x: -100, y: 250)
        addChild(star)
        
        visualGravity!.position = planet1.position
        addChild(visualGravity!)
    }

    override public func setGravity() {
        gravity.strength = 0.95
    }
}










