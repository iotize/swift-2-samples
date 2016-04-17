//: Example from WWDC 2015 Protocol-Oriented in Swift

import UIKit

let twoPi = CGFloat(M_PI * 2)

protocol Renderer {
    func moveTo(p: CGPoint)
    func lineTo(p: CGPoint)
    func circleAt(center: CGPoint, radius: CGFloat)
    func arcAt(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat)
}

// extension has no name?... is it possible to name? or is that lost?
extension Renderer {
    // circleAt doesn't require any specific methods from knowing about the type conforming to this protocol.
    // it's possible to call other protocol methods to basically create a convenience method in this case.
    func circleAt(center: CGPoint, radius: CGFloat) {
        arcAt(center, radius: radius, startAngle: 0, endAngle: twoPi)
    }
    
    func rectangleAt(edges: CGRect) {
        print("protocol extension rectangleAt called")
    }
}

struct TestRenderer : Renderer {
    func moveTo(p: CGPoint) {
        print("moveTo(\(p.x), \(p.y))")
    }
    
    func lineTo(p: CGPoint) {
        print("lineTo(\(p.x), \(p.y))")
    }
    
    func arcAt(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        print("arcAt(\(center.x), \(center.y), \(radius), \(startAngle), \(endAngle)")
    }
}

extension TestRenderer {
    func circleAt(center: CGPoint, radius: CGFloat) {
        print("circleAt(\(center.x), \(center.y), \(radius)")
    }
    
    func rectangleAt(edges: CGRect) {
        print("rectangleAt(\(edges.origin.x), \(edges.origin.y), \(edges.size.width), \(edges.size.height)")
    }
}

/*:
In this example, `rectangleAt` isn't a requirement specified by the protocol.
With the downcast to `Renderer` (as would be the case if called in a generic function, for example), the implementation in `TestRenderer` is ignored, and the extended implementation used.
*/
let r: Renderer = TestRenderer()
r.circleAt(CGPoint(x: 48, y: 48), radius: 16)
r.rectangleAt(CGRect(x: 32, y: 32, width: 64, height: 64))

//: In this example, there is no downcast to `Renderer` and so the `TestRenderer` extended implementation is called.
let t = TestRenderer()
t.circleAt(CGPoint(x: 48, y: 48), radius: 16)
t.rectangleAt(CGRect(x: 32, y: 32, width: 64, height: 64))

/*:
## Constraining Protocol Extensions

Adding `indexOf` as a method in a protocol extension:

    extension CollectionType {
        public func myIndexOf(element: Generator.Element) -> Index? {
            for i in self.indices {
                if self[i] == element {
                    return i
                }
            }
            return nil
        }
    }

But `==` requires conformance to `Comparable`, so we have to constrain the extension:
*/

extension CollectionType where Generator.Element : Comparable {
    public func myIndexOf(element: Generator.Element) -> Index? {
        for i in self.indices {
            if self[i] == element {
                return i
            }
        }
        return nil
    }
}

//: ### `Ordered`

protocol Ordered {
    func precedes(other: Self) -> Bool
}

func binarySearch<T: Ordered>(sortedKeys: [T], forKey k: T) -> Int {
    // imagine this was implemented
    return 0
}

/*:
This doesn't work, because neither `Int` nor `String` conform to `Ordered`:

    let intPosition = binarySearch([2, 3, 5, 7], forKey: 5)
    let stringPosition = binarySearch(["2", "3", "5", "7"], forKey: "5")

So we can add that with extensions:

    extension Int : Ordered {
        func precedes(other: Int) -> Bool { return self < other }
    }

    extension String : Ordered {
        func precedes(other: Int) -> Bool { return self < other }
    }

But that creates redundancy, as it's written twice.

Instead, we can do this:
*/

extension Ordered where Self : Comparable {
    func precedes(other: Self) -> Bool { return self < other }
}

// We still have to declare which types conform to it:
extension Int : Ordered {}
extension String : Ordered {}
extension Double : Ordered {}

let intPosition = binarySearch([2, 3, 5, 7], forKey: 5)
let stringPosition = binarySearch(["2", "3", "5", "7"], forKey: "5")

/*: ### Generic beautification

Swift 1 'angle blindness' with generic on global functions:

    func binarySearch<
        C : CollectionType where C.Index == RandomAccessIndexType,
        C.Generator.Element : Ordered
        >(sortedKeys: C, forKey k: C.Generator.Element) -> Int {
            // ...
    }

    let pos = binarySearch([2, 3, 5, 7, 11, 13, 17], forKey: 5)

Swift 2 type-oriented method:
*/

// I've omitted `RandomAccessIndexType` due to changes in Swift breaking this since Swift 2 release.
extension CollectionType where Generator.Element : Ordered {
    func binarySearch(forKey: Generator.Element) -> Int {
        // ...
        return 0
    }
}

// methody!
let pos = [2, 3, 5, 7, 11, 13, 17].binarySearch(5)

//: ### Interface Generation
//: Uncomment `choices.` to review the interface generated automatically by conforming to `OptionSetType`, which is itself a protocol.

struct Choices : OptionSetType {
    let rawValue: Int
}

var choices = Choices()
// choices.
