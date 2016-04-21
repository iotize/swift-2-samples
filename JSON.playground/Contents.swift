//: Playground - noun: a place where people can play

// Source: https://gist.github.com/chriseidhof/48243eb549481bc38d58

import Foundation

struct Person {
    var name: String = "John"
    var age: Int = 50
    var dutch: Bool = false
    var address: Address? = Address(street: "Market St.")
}

struct Address {
    var street: String
}

let john = Person()

extension MirrorType {
    var children: [(String,MirrorType)] {
        var result: [(String, MirrorType)] = []
        for i in 0..<self.count {
            result.append(self[i])
        }
        return result
    }
}

protocol JSON {
    func toJSON() throws -> AnyObject?
}

enum CouldNotSerializeError {
    case NoImplementation(source: Any, type: MirrorType)
}

extension CouldNotSerializeError: ErrorType { }


extension JSON {
    func toJSON() throws -> AnyObject? {
        let mirror = reflect(self)
        if mirror.count > 0  {
            var result: [String:AnyObject] = [:]
            for (key, child) in mirror.children {
                if let value = child.value as? JSON {
                    result[key] = try value.toJSON()
                } else {
                    throw CouldNotSerializeError.NoImplementation(source: self, type: child)
                }
            }
            return result
        }
        return self as? AnyObject
    }
}

extension Person: JSON { }
extension String: JSON { }
extension Int: JSON { }
extension Bool: JSON { }
extension Address: JSON { }
extension Optional: JSON {
    func toJSON() throws -> AnyObject? {
        if let x = self {
            if let value = x as? JSON {
                return try value.toJSON()
            }
            throw CouldNotSerializeError.NoImplementation(source: x, type: reflect(x))
        }
        return nil
    }
}

do {
    try john.toJSON()
} catch {
    print(error)
}
