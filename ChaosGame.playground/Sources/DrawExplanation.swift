import Foundation
import SpriteKit

public class DrawExplanation : ChaosGameScene{
    //CLASS INITIALIZERS
    //--Required For Serialization
    public required init?(coder aDecoder: NSCoder) {
        cPalette = [#colorLiteral(red: 252/255, green: 244/255, blue: 240/255, alpha: 1.0), #colorLiteral(red: 0, green: 0.7647058824, blue: 1, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.4470588235, blue: 0.2078431373, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.6549019608, blue: 0.2078431373, alpha: 1)]
        maxNodes = 2000
        super.init(coder: aDecoder)
    }
    //--Standard Initializer
    public init(size: CGSize, vertices : Int = 3, maxNodeCount : Int = 2000, dotSize : CGFloat = 100, jmpVertex : Bool = false, extSwitch : Bool = false, histC : Int = 0,  colorP : [UIColor] = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], _ colorP2 : [UIColor] = [#colorLiteral(red: 252/255, green: 244/255, blue: 240/255, alpha: 1.0), #colorLiteral(red: 0.9960784314, green: 0.4470588235, blue: 0.2078431373, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.6549019608, blue: 0.2078431373, alpha: 1), #colorLiteral(red: 0, green: 0.7647058824, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.4666666667, blue: 1, alpha: 1)]) {
        cPalette = colorP
        maxNodes = maxNodeCount
        super.init(CanvasSize: size)
    }


    var step = 0
    var pathLine = CGMutablePath()
    var nodeCount : Int = 1000
    var maxNodes : Int
    var timeCount : Double = 1
    let cPalette : [UIColor]

    //METHODS

    //View Functions

    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.backgroundColor = cPalette[0]
        inscribeRadius = size.width > size.height ? size.height/2 : size.width/2
        polygonVertices = []
        self.isPaused = true
        pathLine = CGMutablePath()
        centerPoint = CGPoint(x: size.width/2, y: size.height/2)
        drawVertex(cPalette[1].cgColor)
        step = 0
    }

    public override func update(_ currentTime: TimeInterval) {
        if nodeCount > 0{
                let chaos = Int.random(in: 0..<3)
                pathLine = CGMutablePath()
                pathLine.addLines(between: [polygonVertices[chaos],lastDotNode.position])
                let n = SKShapeNode(path: pathLine)
                n.lineWidth = 2
                n.strokeColor = cPalette[2]
                n.alpha = 0
                n.run(SKAction.sequence([SKAction.fadeIn(withDuration: timeCount),SKAction.fadeOut(withDuration: timeCount),SKAction.run({
                    n.removeFromParent()
                })]))
                addChild(n)
                self.lastDotNode.removeFromParent()
                self.addChild(self.lastDotNode)
                let position = chaosPoint(from: polygonVertices[chaos], to: lastDotNode.position)
                placeDot(on: position, withSizeOf: dotScale * dotSize, dotColor: cPalette[3].cgColor)
                lastDotNode.alpha = 0
                lastDotNode.run(SKAction.fadeIn(withDuration: timeCount))
                nodeCount -= 1
        }
    }

    override func texturize() {
        return
    }


    //Touch Functions
    public override func touchDown(atPoint pos: CGPoint) {
        if step == 0{
            placeDot(on: pos, withSizeOf: dotScale * dotSize, dotColor: cPalette[4].cgColor)
        }
    }
    public override func touchMoved(toPoint pos: CGPoint) {
        if step == 0{
            lastDotNode.position = pos
        }
    }
    public override func touchUp(atPoint pos: CGPoint) {
        if step == 0{
            isPaused = false
            step += 1
        }
    }
}



