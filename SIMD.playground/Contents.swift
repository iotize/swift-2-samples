//: Source: http://www.russbishop.net/swift-2-simd

/*:
> This built-in library gives us a standard interface for working with 2D, 3D, and 4D vector and matrix operations across various processors on OS X and iOS. It automatically falls back to software routines if the CPU doesn't natively support the given operation (for example splitting up a 4-lane vector into two 2-lane operations). It also has the bonus of easily transferring data between the GPU and CPU using Metal.
*/

import UIKit
import simd

let vec = float3(1.0, 1.0, 1.0)
let matrix = float3x3()
let result = vec * matrix

//: also dot product, cross product, reciprocal, length, reflect, refract, min, max, reduce_add, and more

//: # Example
//: Repeatedly count how many random numbers are below a boundary.
//: ## The Normal Way

let array = (0..<100).map { (_) in Float(rand() % 10) }
let vecArray = 0.stride(to: array.count, by: 4)
    .map { (i:Int) -> float4 in
        float4(array[i], array[i + 1], array[i + 2], array[i + 3])
}

func doNormalCount() {
    for boundary in 0...10 {
        let negBoundary = -Float(boundary - 1)
        var total = 0
        
        let timer = NSDate()
        for _ in 0..<1000 {
            var count = Float()
            for var i in array {
                i += negBoundary
                i = sign(i)
                i = max(i, 0)
                count += i
            }
            total += (array.count - Int(count))
        }
        
        let elapsed = NSDate.timeIntervalSinceDate(timer)
        print("NORM: count = \(total), time = \(elapsed)ms")
    }
}

func doSimdCount() {
    for boundary in 0...10 {
        let negBoundary = float4(-Float(boundary - 1))
        var total = 0
        
        let timer = NSDate()
        for _ in 0..<1000 {
            var counts = float4()
            for i in 0..<vecArray.count {
                var v = vecArray[i]
                v += negBoundary
                v = sign(v)
                v = max(v, 0.0)
                counts += v
            }
            total += (array.count - Int(reduce_add(counts)))
        }
        
        let elapsed = NSDate.timeIntervalSinceDate(timer)
        print("SIMD: count = \(total), time = \(elapsed)ms")
    }
}

doNormalCount()
doSimdCount()
