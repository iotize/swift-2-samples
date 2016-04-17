//: Playground - noun: a place where people can play

import UIKit

print("example 1")
for i in 1..<5 {
    guard i < 3 else {
        print("\(i) >= 3")
        continue
    }
    print(i)
}

print("example 2")
for i in 1..<5 {
    guard i < 3 else {
        print("\(i) >= 3")
        break
    }
    print(i)
}

print("example 3")
func loop() {
    for i in 1..<5 {
        guard i < 3 else {
            print("\(i) >= 3")
            return
        }
        print(i)
    }
}
loop()

struct Example {
    var enabled: Bool = false
    
    var value: String {
        get {
            guard enabled else {
                // this branch executed only if enabled NOT true
                return "Not Enabled"
            }
            
            // continues if enabled IS true
            return "Enabled"
        }
    }
    
    init(enabled: Bool) {
        self.enabled = enabled
    }
}

let a = Example(enabled: true)
print(a.value) // expectation: "Enabled"

let b = Example(enabled: false)
print(b.value) // expectation: "Not Enabled"

func doSomething(test: Bool) -> String {
    guard test else {
        return "test is false"
    }
    
    return "test is true"
}

print(doSomething(true))
print(doSomething(false))
