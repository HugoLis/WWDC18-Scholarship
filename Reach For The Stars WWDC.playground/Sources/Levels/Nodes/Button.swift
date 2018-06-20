import SpriteKit

public class Button: SKSpriteNode {
    var engineIsOff = true
    
    enum FTButtonActionType: Int {
        case TouchUpInside = 1,
        TouchDown, TouchUp
    }
    
    var isEnabled: Bool = true {
        didSet {
            if (disabledTexture != nil) {
                texture = isEnabled ? defaultTexture : disabledTexture
            }
        }
    }
    
    public var isSelected: Bool = false {
        didSet {
            texture = isSelected ? selectedTexture : defaultTexture
        }
    }
    
    var defaultTexture: SKTexture
    var selectedTexture: SKTexture
    var label: SKLabelNode
    
    required public init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    public init(normalTexture defaultTexture: SKTexture!, selectedTexture:SKTexture!, disabledTexture: SKTexture?) {
        
        self.defaultTexture = defaultTexture
        self.selectedTexture = selectedTexture
        self.disabledTexture = disabledTexture
        self.label = SKLabelNode(fontNamed: "Helvetica");
        
        super.init(texture: defaultTexture, color: UIColor.white, size: defaultTexture.size())
        isUserInteractionEnabled = true
    }
    
    public init() {
        
        self.defaultTexture = SKTexture()
        self.selectedTexture = SKTexture()
        self.disabledTexture = SKTexture()
        self.label = SKLabelNode(fontNamed: "Helvetica");
        
        super.init(texture: defaultTexture, color: UIColor.white, size: defaultTexture.size())
        isUserInteractionEnabled = true
        
        self.label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center;
        self.label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center;
        addChild(self.label)
        
        let bugFixLayerNode = SKSpriteNode(texture: nil, color: UIColor.clear, size: defaultTexture.size())
        bugFixLayerNode.position = self.position
        addChild(bugFixLayerNode)
    }
    
    var disabledTexture: SKTexture?
    var actionTouchUpInside: Selector?
    var actionTouchUp: Selector?
    var actionTouchDown: Selector?
    weak var targetTouchUpInside: AnyObject?
    weak var targetTouchUp: AnyObject?
    weak var targetTouchDown: AnyObject?
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (!isEnabled) {
            return
        }
        isSelected = true
        startEngine()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02, execute: {
            self.setGravity()
        })
        
    }
    
    public func startEngine() {
        
        if engineIsOff{
            let parentNode = self.parent as! GameScene
            parentNode.rocket.addChild(parentNode.fire!)
            parentNode.thrustSound.autoplayLooped = true
            parentNode.addChild(parentNode.thrustSound)
            engineIsOff = false
        }
    }
    
    public func setGravity() {
        
        let parentNode = self.parent as! GameScene
        parentNode.setGravity()
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (!isEnabled) {
            return
        }
        stopEngine()
        isSelected = false
    }
    
    public func stopEngine (){
        
        let parentNode = self.parent as! GameScene
        parentNode.fire!.removeFromParent()
        parentNode.thrustSound.removeFromParent()
        engineIsOff = true
    }
}
