//: Note: This is probably a terrible idea.

import Foundation

enum SelectorIdentifier : Selector {
    case Description = "description"
    case DebugDescription = "debugDescription"
}

extension NSObject {
    func performSelectorWithIdentifier(identifier: SelectorIdentifier) -> Unmanaged<AnyObject>! {
        return performSelector(identifier.rawValue)
    }
}

let object = ["a", "b", "c"] as NSArray

print(object.performSelectorWithIdentifier(.Description))

print(object.performSelectorWithIdentifier(.DebugDescription))
