import UIKit
import SpriteKit


var bullets = [SKSpriteNode]() //deprecated
var enemies = [SKSpriteNode]() //deprecated

var nextEnemyLocation = 3
struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Ship   : UInt32 = 0b1
    static let Bullet: UInt32 = 0b10
    static let Enemy: UInt32 = 0b11
}

var debug = false
var oldRandom: Int = -1
var oldOldRandom: Int = -1

extension Int
{
    static func random(start: Int, end: Int) -> Int{
        return random(range: Range(uncheckedBounds: (lower: start, upper: end)))
    }
    
    static func random(range: Range<Int>) -> Int{
        var offset = 0
        
        if range.lowerBound < 0   // allow negative ranges
        {
            offset = abs(range.lowerBound)
        }
        
        let mini = UInt32(range.lowerBound + offset)
        let maxi = UInt32(range.upperBound   + offset)
        
        let random = Int(mini + arc4random_uniform(maxi - mini)) - offset
        if random != oldRandom {
            if random != oldOldRandom {
                oldOldRandom = random
            }
            else {
                oldRandom = random
            }
            return random
        }
        else {
            return Int.random(range: range)
        }
    }
    
    func formatted() -> String? {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.string(from: NSNumber(value: self))
        fmt.locale = NSLocale(localeIdentifier: "fr_FR") as Locale!
        var string = fmt.string(from: NSNumber(value: self))  // "2 358 000"
        string = string?.replacingOccurrences(of: "", with: ",")
        return string
    }
}

internal struct CStyleLoop: Sequence, IteratorProtocol
{
    let condition: () -> Bool
    let increment: () -> Void
    var started = false
    
    internal init(
        _ condition: @autoclosure @escaping () -> Bool,
        _ increment: @autoclosure @escaping () -> Void)
    {
        self.increment = increment
        self.condition = condition
    }
    
    internal func makeIterator() -> CStyleLoop
    {
        return self
    }
    
    internal mutating func next() -> Void?
    {
        if started
        {
            increment()
        }
        else
        {
            started = true
        }
        
        if condition()
        {
            return ()
        }
        return nil
    }
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    ///Usage: 0xHEXCODE
    convenience init(netHex:Int) {
        
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    //colors for app
    
    public static var shapesRed: UIColor {
        get {
            return UIColor(red: 251, green: 0, blue: 2)
        }
    }
    
    static var shapesBlue: UIColor {
        get {
            return UIColor(red: 0, green: 1, blue: 254)
        }
    }
    
    static var shapesGreen: UIColor {
        get {
            return UIColor(red: 15, green: 97, blue: 40)
        }
    }
    
    static var shapesOrange: UIColor {
        get {
            return UIColor(red: 243, green: 129, blue: 22)
        }
    }
    
    static var shapesYellow: UIColor {
        get {
            return UIColor(red: 255, green: 254, blue: 10)
        }
    }
    
    static var shapesPurple: UIColor {
        get {
            return UIColor(red: 249, green: 0, blue: 254)
        }
    }
    
}

extension Array {
    static func set(array: [String]) -> Set<String>{
        var set = Set<String>()
        for item in array {
            set.insert(item)
        }
        return set
    }
}


postfix operator ++

postfix func ++ ( x: inout Int) -> Int{
    x += 1
    return x
}

postfix operator --

postfix func -- ( x: inout Int) -> Int{
    x -= 1
    return x
}

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
