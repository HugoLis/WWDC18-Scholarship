import SpriteKit

public class YouWonScene: SKScene {

    let star = SKSpriteNode(imageNamed: "Star/star")
    let starField = SKEmitterNode(fileNamed:"Particles/Stars")
    let winParticle = SKEmitterNode(fileNamed:"Particles/WinParticle")
    var starCount =  SKSpriteNode(imageNamed: "StarCounter/1:6stars")
    
        
    override public func didMove(to view: SKView){
        backgroundColor = UIColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)
        
        star.setScale(0.5)
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
        label1.text = "You Did It!"
        label1.fontSize = 40
        label1.fontColor = SKColor.white
        label1.position = CGPoint(x: size.width/2, y: size.height/2 + 180)
        addChild(label1)
        
        let label3 = SKLabelNode(fontNamed: "Helvetica")
        label3.text = "Tap to play the next level."
        label3.fontSize = 22
        label3.fontColor = SKColor.white
        label3.position = CGPoint(x: size.width/2, y: size.height/2 - 200)
        addChild(label3)
    }
    
}

