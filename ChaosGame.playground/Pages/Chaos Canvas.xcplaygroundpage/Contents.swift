//#-hidden-code
import Foundation
import PlaygroundSupport
import SpriteKit

public enum DotsScale: Double {
    case Medium = 0.75
    case ExtraSmall = 0.25
    case Small = 0.5
    case Large = 1.0
    case ExtraLarge = 2.0
}

public enum Modifier {
    case On
    case Off
}

public enum ColoringMode: Int {
    case Default = 0
    case ColorByCurrentVertex = 1
    case ColorByPastVertex = 2
    case Monochrome = 4
}

public var SizeOfPolygon : Int = 3
public var ExternalFractals : Modifier = .Off
public var JumpLastVertex : Modifier = .Off
public var TypeOfColoring : ColoringMode = .Default
public var NumberOfDots : Int = 1000
public var DotsSize : DotsScale = .ExtraSmall
public var DotsColorPalette : [CGColor] = [#colorLiteral(red: 0, green: 0.7651365399, blue: 0.9986177087, alpha: 1), #colorLiteral(red: 0.0007253905642, green: 0.4668268561, blue: 0.9992229342, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)]
public var BackgroundColor : CGColor = #colorLiteral(red: 0.9882352941, green: 0.9607843137, blue: 0.937254902, alpha: 1)
public var DrawRangeColor : CGColor = #colorLiteral(red: 0.9978044629, green: 0.4458022714, blue: 0.2069864273, alpha: 1)
public var LimitRangeColor : CGColor = #colorLiteral(red: 0.9955810905, green: 0.6538415551, blue: 0.2082905173, alpha: 1)
//#-end-hidden-code

/*:
 # Chaos Canvas

 ### Welcome to the Chaos Game!
 First things first, have you ever drew a snowflake?
Nature is pretty profficient in making art from Chaos. Let's see if we can replicate some of it's designs.

 - Experiment:
 Execute this playground and try to draw some snowflakes.
 \
Just tap your finger anywhere on the screen and drag it to a size that you like it.

* Important:
  To clear the screen, rotate the device or stop and execute again the code.

 Okay, maybe snowflakes are not the first thing that comes to mind when people think about **Chaos**.
 \
 But why don't we try to remedy this with some special "brushes"?

* Experiment:
    Change the paramenters bellow and see what kind of results you can get! \ Don't worry, in the next page of this playground there will be some better explanations.
* Note:
    - Changes in the modifiers bellow take effect only by executing the code after changing them.
    - Due to special characteristics, the square doesn't have an easily visible pattern. Try adding some coloring!
 */

//#-code-completion(everything, hide)
SizeOfPolygon = /*#-editable-code Size Of Polygon*/4/*#-end-editable-code*/
NumberOfDots = /*#-editable-code*/6000/*#-end-editable-code*/
ExternalFractals = /*#-editable-code*/.Off/*#-end-editable-code*/
JumpLastVertex = /*#-editable-code*/.Off/*#-end-editable-code*/
TypeOfColoring = /*#-editable-code*/.ColorByPastVertex/*#-end-editable-code*/

/*:
 And finally: what would a canvas be without some **color palettes!**
 \
 Bellow, you can change the color of all the elements of the canvas.

* Important:
 Although not necessary to use this canvas, it's highly recommended that you go look at the next page. The name is not for show, there's a lot o chaos behind these shapes.
*/

DotsColorPalette = /*#-editable-code*/[#colorLiteral(red: 0, green: 0.7651365399, blue: 0.9986177087, alpha: 1), #colorLiteral(red: 0.0007253905642, green: 0.4668268561, blue: 0.9992229342, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)]/*#-end-editable-code*/
BackgroundColor = /*#-editable-code*/#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1) /*#-end-editable-code*/
DrawRangeColor = /*#-editable-code*/#colorLiteral(red: 0.9978044629, green: 0.4458022714, blue: 0.2069864273, alpha: 1) /*#-end-editable-code*/
LimitRangeColor = /*#-editable-code*/#colorLiteral(red: 0.9955810905, green: 0.6538415551, blue: 0.2082905173, alpha: 1) /*#-end-editable-code*/

//#-hidden-code
SizeOfPolygon = (SizeOfPolygon <= 3) ? 3 : SizeOfPolygon
NumberOfDots = (NumberOfDots <= 1) ? 1 : NumberOfDots
DotsColorPalette = (DotsColorPalette == []) ? [#colorLiteral(red: 0, green: 0.7651365399, blue: 0.9986177087, alpha: 1), #colorLiteral(red: 0.0007253905642, green: 0.4668268561, blue: 0.9992229342, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)] : DotsColorPalette
if TypeOfColoring == ColoringMode.Monochrome {
    DotsColorPalette = [DotsColorPalette[0]]
}
let external: Bool = (ExternalFractals == .On)
let jumpVertex: Bool = (JumpLastVertex == .On)
//#-end-hidden-code

//#-hidden-code
//Scene Creator
let frmView = CGRect(x:0 , y:0, width: 768, height: 1024) //View Size
let scnView = SKView(frame: frmView) //Scene View
let scn = ChaosGameScene(CanvasSize: frmView.size, NumberOfVertices: SizeOfPolygon, QuantityOfDots: NumberOfDots, DotsScale: CGFloat(DotsSize.rawValue), ShouldJumpLastVertex: jumpVertex, ShouldMakeExternal: external, ShouldColorByHistory: TypeOfColoring.rawValue, DotsColorPalette: DotsColorPalette, AuxiliaryColorPalette: [BackgroundColor, DrawRangeColor, LimitRangeColor, DotsColorPalette[0], DotsColorPalette[1]])//SceneInstance
//Scene Modifiers
scn.scaleMode = .resizeFill

//Scene Presentation
scnView.presentScene(scn)

//View -> liveView
PlaygroundSupport.PlaygroundPage.current.liveView = scnView

//#-end-hidden-code

//: [Next](@next)
