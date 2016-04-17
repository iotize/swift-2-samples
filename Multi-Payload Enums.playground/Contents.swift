//: The use of multiple types for a generic enum would have failed in Swift 1, but is fixed in Swift 2.

import Foundation

enum Either<T1, T2> {
    case First(T1)
    case Second(T2)
}

var a: Either<String, Int>

a = .First("String")
a = .Second(10)

// both work!
