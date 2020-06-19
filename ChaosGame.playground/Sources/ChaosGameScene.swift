//
//  File2.swift
//  UISplitViewStudy
//
//  Created by Rafael Galdino on 17/05/20.
//  Copyright © 2020 Rafael Galdino. All rights reserved.
//
import Foundation
import SpriteKit

open class ChaosGameScene : SKScene{
    //CLASS INITIALIZERS
    //--Required For Serialization
    public required init?(coder aDecoder: NSCoder) {
        numberOfVertices = 6
        totalOfDots = 2000
        dotScale = 1

        super.init(coder: aDecoder)
    }

    //--Default Initializer
    public init(CanvasSize size: CGSize,
                NumberOfVertices vertices : Int = 3,
                QuantityOfDots maxDots : Int = 2000,
                DotsScale scale: CGFloat = 0.5,
                ShouldJumpLastVertex jmpVertex : Bool = false,
                ShouldMakeExternal extSwitch : Bool = false,
                ShouldColorByHistory histC : Int = 0,
                DotsColorPalette  dotsColors : [CGColor] = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],
                AuxiliaryColorPalette playgroundColors : [CGColor] = [#colorLiteral(red: 252/255, green: 244/255, blue: 240/255, alpha: 1.0), #colorLiteral(red: 0.9960784314, green: 0.4470588235, blue: 0.2078431373, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.6549019608, blue: 0.2078431373, alpha: 1), #colorLiteral(red: 0, green: 0.7647058824, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.4666666667, blue: 1, alpha: 1)]) {

        self.numberOfVertices = vertices
        self.isExternal = extSwitch
        self.dotsColorScheme = dotsColors
        self.playgroundColorScheme = playgroundColors
        self.totalOfDots = maxDots
        self.dotScale = scale
        self.isJumpingVertex = jmpVertex
        self.colorHistoryOption = histC

        self.inscribeRadius = 10
        self.lastDotNode = SKShapeNode(circleOfRadius : 10)
        self.polygonVertices = []

        super.init(size: size)
    }

    //ATTRIBUTES
    //--Internal Variables
    open var dotsRemaining: Int = 0
    open var rangeRadius: SKShapeNode = SKShapeNode(circleOfRadius: 1)
    open var rootNode: SKEffectNode = SKEffectNode()
    open var colorpicker: Int = 0
    open var lastVertex: Int = -1
    open var colorHistoryAux: Int = 0
    open var dotsCounter: Int = 0

    //--Open Variables
    open var dotSize: CGFloat = 0
    open var centerPoint: CGPoint = CGPoint(x: 0, y: 0)
    open var inscribeRadius: CGFloat = 0.0
    open var lastDotNode: SKShapeNode = SKShapeNode(ofRadius: 1)
    open var polygonVertices: [CGPoint] = []

    //--User Set Constants
    let numberOfVertices: Int
    let totalOfDots: Int
    let dotScale: CGFloat
    var dotsColorScheme: [CGColor] = [#colorLiteral(red: 252/255, green: 244/255, blue: 240/255, alpha: 1.0), #colorLiteral(red: 0.9960784314, green: 0.4470588235, blue: 0.2078431373, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.6549019608, blue: 0.2078431373, alpha: 1), #colorLiteral(red: 0, green: 0.7647058824, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.4666666667, blue: 1, alpha: 1)]
    var playgroundColorScheme: [CGColor] = [
        CGColor(srgbRed: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
        CGColor(srgbRed: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
        CGColor(srgbRed: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),
        CGColor(srgbRed: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),
        CGColor(srgbRed: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),
        CGColor(srgbRed: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),
        CGColor(srgbRed: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1),
        CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1)
    ]

    var colorHistoryOption: Int = 0
    var isExternal: Bool = false
    var isJumpingVertex: Bool = false

    //VIEW FUNCTIONS
    open override func sceneDidLoad() {
        didChangeSize(self.size)
    }

    open override func didMove(to view: SKView) {
        newScene(with: view)
        super.didMove(to: view)
    }

    open override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        guard let myView = self.view else { return }
        newScene(with: myView)
    }

    open func resetScene() {
        self.isPaused = true
        texturize()
        rootNode.removeAllChildren()
        rootNode.removeFromParent()
        addChild(rootNode)
    }

    open func newScene(with view: SKView) {
        self.isPaused = true
        resetScene()
        let viewSize = view.frame.size
        dotSize = (viewSize.height >= viewSize.width ? viewSize.width : viewSize.height)/100
        self.backgroundColor = UIColor(cgColor: playgroundColorScheme[0])
        self.lastDotNode = SKShapeNode()
        dotsRemaining = totalOfDots
        polygonVertices = []
        rootNode.shouldRasterize = true
        rootNode.shouldEnableEffects = true
    }

    open override func update(_ currentTime: TimeInterval) {
        if dotsRemaining > 0{
            for _ in 0..<5 {
                var chosenVertex = Int.random(in: 0..<numberOfVertices)
                if isJumpingVertex{
                    while chosenVertex == lastVertex{
                        chosenVertex = Int.random(in: 0..<numberOfVertices)
                    }
                    lastVertex = chosenVertex
                }
                let position = chaosPoint(from: polygonVertices[chosenVertex], to: lastDotNode.position)
                placeDot(on: position, withSizeOf: dotSize * dotScale, dotColor:cycleColors(for: chosenVertex))
                dotsRemaining -= 1
                dotsCounter += 1
            }
        }
        if dotsCounter == 1000 {
            dotsCounter = 0
            texturize()
        }
    }

    private func cycleColors(for vertexAt: Int = 0) -> CGColor {
        switch colorHistoryOption {
        case 1:
            colorpicker = vertexAt
        case 2:
            colorpicker = colorHistoryAux
            colorHistoryAux = vertexAt
        default:
            colorpicker += 1
        }
        colorpicker = colorpicker >= dotsColorScheme.count ? 0 : colorpicker
        return dotsColorScheme[colorpicker]
    }

    //TOUCH FUNCTIONS
    open func touchDown(atPoint pos : CGPoint) {
        resetScene()
        let dotColor = isExternal ? playgroundColorScheme[1] : playgroundColorScheme[2]
        centerPoint = pos
        placeDot(on: pos, withSizeOf: dotSize, dotColor: dotColor)
    }

    open func touchMoved(toPoint pos : CGPoint) {
        rangeRadius.removeFromParent()
        let n = CGMutablePath()
        inscribeRadius = CGFloat(
            sqrtf(
                (powf(Float(abs(pos.x - centerPoint.x)), 2))
                    +
                    powf(Float(abs(pos.y - centerPoint.y)), 2)
            )
        )
        n.addArc(center: lastDotNode.position, radius: inscribeRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        rangeRadius = SKShapeNode(path: n)
        rangeRadius.lineWidth = 5
        let lineColor = isExternal ? playgroundColorScheme[2] : playgroundColorScheme[1]
        rangeRadius.strokeColor = UIColor(cgColor: lineColor)
        addChild(rangeRadius)
    }

    open func touchUp(atPoint pos : CGPoint) {
        lastDotNode.fillColor = UIColor.clear
        lastDotNode.lineWidth = 0
        rangeRadius.lineWidth = 0
        dotsRemaining = totalOfDots
        let vertexColor = isExternal ? playgroundColorScheme[2] : playgroundColorScheme[1]
        drawVertex(vertexColor)
        self.isPaused = false
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }



    //DRAWING FUNCTIONS
    open func drawVertex(_ color: CGColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)){
        polygonVertices = verticesPoints(sides: numberOfVertices, radius: inscribeRadius, origin: centerPoint)
        for vertice in polygonVertices {
            placeDot(on: vertice, withSizeOf: dotSize * dotScale, dotColor: color)
        }
    }

    private func verticesPoints(sides: Int, radius: CGFloat, origin: CGPoint) -> [CGPoint] {
        var points: [CGPoint] = []
        for index in 0..<sides {
            let angle = CGFloat(index) * (CGFloat.pi*2 / CGFloat(sides)) + CGFloat.pi*0.5
            let x = CGFloat(radius) * cos(angle) + origin.x
            let y = CGFloat(radius) * sin(angle) + origin.y
            points.append(CGPoint(x: x, y: y))
        }
        return points
    }

    open func placeDot(on pos : CGPoint, withSizeOf radius : CGFloat, dotColor : CGColor = UIColor.systemRed.cgColor){
        let n : SKShapeNode = SKShapeNode(ofRadius: radius)
        n.fillColor = UIColor(cgColor: dotColor)
        n.position = pos
        rootNode.addChild(n)
        self.lastDotNode = n
    }

    private func chaosRate(_ numberOfSides: Int) -> CGFloat{
        var partialRate = kissingValue(numberOfSides)
        if isExternal {
            partialRate = 2.0 - partialRate
        }
        return partialRate
    }

    private var kissingValue: (Int) -> CGFloat = { (_ vertices: Int) -> CGFloat in
        var kissingVertex : Float = Float(vertices)/4
        kissingVertex.round(.up)

        let alpha = Float(CGFloat.pi / CGFloat(vertices))
        let beta = 2 * alpha * (kissingVertex - 0.5)
        let gamma = beta - (Float.pi * 0.5)

        return CGFloat(1 - (sinf(alpha) / (sinf(alpha) + cosf(gamma))))
    }

    public func chaosPoint(from pointA: CGPoint, to pointB: CGPoint) -> CGPoint{
        let rate = chaosRate(numberOfVertices)
        let newX = (pointA.x * rate + pointB.x * (1 - rate))
        let newY = (pointA.y * rate + pointB.y * (1 - rate))
        return CGPoint(x: newX, y: newY)
    }

    func texturize() {
        let spriteNode = SKSpriteNode(texture: view?.texture(from: rootNode))
        spriteNode.position = centerPoint
        rootNode.removeAllChildren()
        addChild(spriteNode)
    }
}

extension SKShapeNode {
    convenience init(ofRadius: CGFloat) {
        self.init(circleOfRadius: ofRadius)
        physicsBody = nil
        lineWidth = 0
    }
}
