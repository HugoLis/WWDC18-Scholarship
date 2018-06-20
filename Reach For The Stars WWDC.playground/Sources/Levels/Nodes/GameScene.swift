import SpriteKit

public class GameScene: SKScene, SKPhysicsContactDelegate {

    public var rocket = SKSpriteNode(imageNamed: "Rocket/rocket")
    public var gravity = SKFieldNode.radialGravityField()
    public var gravity2 = SKFieldNode.radialGravityField()
    let thrustSound = SKAudioNode(fileNamed: "Sounds/rocketThrust.wav")
    let fire = SKEmitterNode(fileNamed:"Particles/Fire")
    
    let star = SKSpriteNode(imageNamed: "Star/star")
    var button = Button()
    let explosion = SKEmitterNode(fileNamed: "Particles/Explosion")
    let starField = SKEmitterNode(fileNamed:"Particles/Stars")
    
    let leftWall = SKSpriteNode(color: UIColor.brown, size: CGSize(width: 50, height: 760))
    let rightWall = SKSpriteNode(color: UIColor.brown, size: CGSize(width: 50, height: 760))
    let topWall = SKSpriteNode(color: UIColor.brown, size: CGSize(width: 580, height: 50))
    let bottomWall = SKSpriteNode(color: UIColor.brown, size: CGSize(width: 580, height: 50))
    public let defaultSize = CGSize(width: 480, height: 640)
    public var youWonScene: YouWonScene = YouWonScene1(size: CGSize(width: 480, height: 640))

    public func setGravity(){
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        self.youWonScene.starCount = SKSpriteNode(imageNamed: "StarCounter/1:6stars")

        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        //Rocket x Planet collision
        if ((firstBody.categoryBitMask == PhysicsCategory.Planet) &&
            (secondBody.categoryBitMask == PhysicsCategory.Rocket)) {
            if let planet = firstBody.node as? SKSpriteNode, let
                rocket = secondBody.node as? SKSpriteNode {
                RocketDidCollideWithPlanet(rocket: rocket, planet: planet)
            }
        }
            //Rocket x Edge collision
        else if ((firstBody.categoryBitMask == PhysicsCategory.Rocket) &&
            (secondBody.categoryBitMask == PhysicsCategory.Edge)) {
            if let rocket = firstBody.node as? SKSpriteNode, let
                edge = secondBody.node as? SKSpriteNode {
                RocketDidCollideWithEdge (rocket: rocket, edge: edge)
            }
        }
            //Rocket x Star collision
        else if ((firstBody.categoryBitMask == PhysicsCategory.Rocket) &&
            (secondBody.categoryBitMask == PhysicsCategory.Star)) {
            if let rocket = firstBody.node as? SKSpriteNode, let
                star = secondBody.node as? SKSpriteNode {
                RocketDidCollideWithStar(rocket: rocket, star: star)
            }
        }
    }
    
    public func RocketDidCollideWithPlanet(rocket: SKSpriteNode, planet: SKSpriteNode) {
        
        let explosionAction = SKAction.run(){
            let explosion = SKEmitterNode(fileNamed:"Particles/Explosion")!
            explosion.position = CGPoint(x: rocket.position.x, y: rocket.position.y)
            self.addChild(explosion)
            self.run(SKAction.playSoundFileNamed("Sounds/rocketCrash.wav", waitForCompletion: false))
            
            rocket.removeFromParent()
            
            self.run(SKAction.wait(forDuration: 0.5)) {
                explosion.removeFromParent()
            }
        }
        
        let resetSceneAction = SKAction.run(){
            //Delay to let the explosion end
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.resetScene()
            })
        }
        self.run(SKAction.sequence([explosionAction, resetSceneAction]))
    }
    
    func resetScene() {
    }
    
    public func RocketDidCollideWithStar(rocket: SKSpriteNode, star: SKSpriteNode) {
        
        let explosionAction = SKAction.run(){
            let explosion = SKEmitterNode(fileNamed:"Particles/Confetti")!
            explosion.position = CGPoint(x: star.position.x, y: star.position.y)
            self.addChild(explosion)
            self.run(SKAction.playSoundFileNamed("Sounds/winSound.wav", waitForCompletion: false))

            rocket.removeFromParent()
            star.removeFromParent()
            
            self.run(SKAction.wait(forDuration: 1.3)) {
                explosion.removeFromParent()
            }
        }
        let resetScene = SKAction.run(){
            //Delay to let the explosion end
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                let reveal = SKTransition.fade(withDuration: 1)
                let gameSize = self.size
                self.loadNextScene(size: gameSize)
                self.view?.presentScene(self.youWonScene, transition: reveal)
            })
        }
        self.run(SKAction.sequence([explosionAction, resetScene]))
    }
    
    func loadNextScene(size: CGSize){
    }
    
    public func RocketDidCollideWithEdge(rocket: SKSpriteNode, edge: SKSpriteNode) {
        rocket.removeFromParent()
        self.resetScene()
    }
    
   override public func didMove(to view: SKView){
    
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        backgroundColor = UIColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)
    
        rocket.physicsBody = SKPhysicsBody(texture: rocket.texture!, size: rocket.size)
        rocket.physicsBody?.isDynamic = true
        rocket.physicsBody?.categoryBitMask = PhysicsCategory.Rocket
        rocket.physicsBody?.contactTestBitMask = PhysicsCategory.Planet
        rocket.physicsBody?.fieldBitMask = PhysicsCategory.Gravity
        rocket.physicsBody?.collisionBitMask = PhysicsCategory.None
    
        rocket.physicsBody?.usesPreciseCollisionDetection = true
        rocket.physicsBody!.mass = 0.1
        rocket.setScale(0.35)
    
        star.setScale(0.5)
        star.physicsBody = SKPhysicsBody(texture: star.texture!, size: star.size)
        star.physicsBody?.isDynamic = false
        star.physicsBody?.categoryBitMask = PhysicsCategory.Star
        star.physicsBody?.contactTestBitMask = PhysicsCategory.Rocket
        star.physicsBody?.collisionBitMask = PhysicsCategory.None
        star.physicsBody?.usesPreciseCollisionDetection = true
    
        starField!.position = CGPoint(x: 0, y: 0)
        starField!.advanceSimulationTime(5)
        addChild(starField!)
    
        gravity.strength = 0
        gravity.categoryBitMask = PhysicsCategory.Gravity
        gravity2.strength = 0
        gravity2.categoryBitMask = PhysicsCategory.Gravity

    
        leftWall.position = CGPoint(x: -325, y: 0)
        leftWall.physicsBody = SKPhysicsBody(rectangleOf: leftWall.size)
        leftWall.physicsBody!.isDynamic = false
        leftWall.physicsBody?.categoryBitMask = PhysicsCategory.Edge
        leftWall.physicsBody?.contactTestBitMask = PhysicsCategory.Rocket
        leftWall.physicsBody?.collisionBitMask = PhysicsCategory.None
        leftWall.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(leftWall)
    
        rightWall.position = CGPoint(x: 325, y: 0)
        rightWall.physicsBody = SKPhysicsBody(rectangleOf: rightWall.size)
        rightWall.physicsBody!.isDynamic = false
        rightWall.physicsBody?.categoryBitMask = PhysicsCategory.Edge
        rightWall.physicsBody?.contactTestBitMask = PhysicsCategory.Rocket
        rightWall.physicsBody?.collisionBitMask = PhysicsCategory.None
        rightWall.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(rightWall)
    
        topWall.position = CGPoint(x: 0, y: 380)
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody!.isDynamic = false
        topWall.physicsBody?.categoryBitMask = PhysicsCategory.Edge
        topWall.physicsBody?.contactTestBitMask = PhysicsCategory.Rocket
        topWall.physicsBody?.collisionBitMask = PhysicsCategory.None
        topWall.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(topWall)
    
        bottomWall.position = CGPoint(x: 0, y: -380)
        bottomWall.physicsBody = SKPhysicsBody(rectangleOf: bottomWall.size)
        bottomWall.physicsBody!.isDynamic = false
        bottomWall.physicsBody?.categoryBitMask = PhysicsCategory.Edge
        bottomWall.physicsBody?.contactTestBitMask = PhysicsCategory.Rocket
        bottomWall.physicsBody?.collisionBitMask = PhysicsCategory.None
        bottomWall.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(bottomWall)
    
        let buttonTexture: SKTexture = SKTexture(imageNamed:"Button/redButton")
        let buttonTextureSelected: SKTexture = SKTexture(imageNamed:"Button/pressedButton")
        button = Button(normalTexture: buttonTexture, selectedTexture: buttonTextureSelected, disabledTexture: buttonTexture)
    
        button.position = CGPoint(x: 120 ,y: -235  )
        button.zPosition = 1
        button.setScale(0.65)
        self.addChild(button)
    
        fire!.position = CGPoint (x: 0, y: -80)
        explosion!.position = CGPoint (x: 0, y: 50)
    }
    
    override public func update(_ currentTime: CFTimeInterval){
        
        if button.isSelected{
            let rocketRotation : CGFloat = rocket.zRotation
            let calcRotation : Float = Float(rocketRotation) + Float(Double.pi/2);
            
            let intensity : CGFloat = 10.0
            
            let xv = intensity * CGFloat(cosf(calcRotation))
            let yv = intensity * CGFloat(sinf(calcRotation))
            let vector : CGVector = CGVector(dx: xv, dy: yv)
            // apply force to rocket
            rocket.physicsBody?.applyForce(vector)
        }
    }
    
    override public func didSimulatePhysics() {
        if let body = rocket.physicsBody {
            if (Double(rocket.physicsBody!.velocity.speed()) > 0.01) {
                rocket.zRotation = body.velocity.angle() - CGFloat(Double.pi / 2)
            }
        }
    }

}
