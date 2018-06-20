import Foundation
import SpriteKit

public class YouWonScene6: SKScene {
    
    let star = SKSpriteNode(imageNamed: "Star/star")
    let starField = SKEmitterNode(fileNamed:"Particles/Stars")
    let winParticle = SKEmitterNode(fileNamed:"Particles/FinalConfetti")
    let starCount = SKSpriteNode(imageNamed: "StarCounter/6:6stars")
    
    override public init(size: CGSize) {
        
        super.init(size: size)
        
        backgroundColor = UIColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)
        
        star.setScale(0.75)
        star.position = CGPoint (x: size.width/2, y: size.height/2 + 50)
        addChild(star)
        
        starCount.setScale(0.5)
        starCount.zPosition = -200
        starCount.position = CGPoint(x: size.width/2, y: size.height/2-150)
        addChild(starCount)
        
        winParticle!.position = star.position
        winParticle!.advanceSimulationTime(3)
        addChild(winParticle!)
        
        starField!.position = CGPoint(x: size.width/2, y: size.height/2)
        starField!.advanceSimulationTime(5)
        addChild(starField!)
        
        let label1 = SKLabelNode(fontNamed: "Helvetica")
        label1.text = "You Won The Game!"
        label1.fontSize = 40
        label1.fontColor = SKColor.white
        label1.position = CGPoint(x: size.width/2, y: size.height/2 + 180)
        addChild(label1)
        
        let label4 = SKLabelNode(fontNamed: "Helvetica")
        label4.text = "Tap to play the game again."
        label4.fontSize = 22
        label4.fontColor = SKColor.white
        label4.position = CGPoint(x: size.width/2, y: size.height/2 - 200)
        addChild(label4)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        if let gameScene = GameScene1(fileNamed: "GameScene"){
            gameScene.scaleMode = .aspectFill
            self.view?.presentScene(gameScene, transition: reveal)
        }
    }
}
