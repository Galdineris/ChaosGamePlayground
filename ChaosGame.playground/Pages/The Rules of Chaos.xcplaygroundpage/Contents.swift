//: [Previous](@previous)

/*:
 # THE RULES

 ## HOW TO DO IT
 in 5 simple steps you will not believe!

  * Callout(Chaos Drawing Instructions):
    1. Chose a polygon (a closed chape with 3 sides or more) and draw its vertices as dots on a plane
    2. Pick any point in said plane and trace a imaginary line to anyone of the vertices of the polygon.
    3. Place a new dot in near the middle of the imaginary line.
    4. From this new dot, trace another imaginary line to a random vertice of the polygon.
    5. Repeat steps 3 and 4 until you're satisfied!

### Don't believe me? Execute the code on this page and see it for yourself!
 \
 To better understand the chaos game, we must first understand what fractals are.
 Fractals are geometric figures which are self-similar, which means parts of them repeats themselfs throughout the figure. In the case of fractals, this repetition is virtually infinite!
 The Chaos Game is just one of the so-called "iterated function systems", algorithms which are capable of generating fractals.
 \
 \
If you would like to learn more about theory behind Chaos Game and how it works, you should check out
 [The Chaos Game at Between Art and Science by Tom Bates](https://www.betweenartandscience.com/chaosgame_words.html)

And that’s it, thank you for your time.
My name is Rafael Galdino and I hope you enjoyed this playground!
 */

//#-hidden-code
import Foundation
import PlaygroundSupport
import SpriteKit

public var SizeOfPolygon : Int = 3
public var ExternalFractals : Bool = false
public var NumberOfDots : Int = 1000
public var BackgroundColor : UIColor = UIColor.red
public var DotsColor : UIColor = UIColor.blue
public var LineColor : UIColor = UIColor.blue
public var VertexColor : UIColor = UIColor.blue
public var InitialDotColor : UIColor = UIColor.blue
//#-end-hidden-code

BackgroundColor =/*#-editable-code Size Of Polygon*/ #colorLiteral(red: 252/255, green: 244/255, blue: 240/255, alpha: 1.0) /*#-end-editable-code*/
LineColor = /*#-editable-code Size Of Polygon*/ #colorLiteral(red: 0.9978044629, green: 0.4458022714, blue: 0.2069864273, alpha: 1) /*#-end-editable-code*/
VertexColor = /*#-editable-code Size Of Polygon*/ #colorLiteral(red: 0.9955810905, green: 0.6538415551, blue: 0.2082905173, alpha: 1) /*#-end-editable-code*/
DotsColor = /*#-editable-code Size Of Polygon*/ #colorLiteral(red: 0, green: 0.7651365399, blue: 0.9986177087, alpha: 1) /*#-end-editable-code*/
InitialDotColor = /*#-editable-code Size Of Polygon*/ #colorLiteral(red: 0, green: 0.4666666667, blue: 1, alpha: 1) /*#-end-editable-code*/

//#-hidden-code

//#-end-hidden-code

//#-hidden-code
//Scene Creator
let frmView = CGRect(x:0 , y:0, width: 768, height: 1024) //View Size
let scnView = SKView(frame: frmView) //Scene View
let scn = DrawExplanation(size: frmView.size, colorP: [BackgroundColor, VertexColor, LineColor, DotsColor, InitialDotColor]) //SceneInstance

//Scene Modifiers
scn.scaleMode = .resizeFill

//Scene Presentation
scnView.presentScene(scn)
scnView.showsDrawCount = true
scnView.showsNodeCount = true
scnView.showsFPS = true

//View -> liveView
PlaygroundSupport.PlaygroundPage.current.liveView = scnView
//#-end-hidden-code
