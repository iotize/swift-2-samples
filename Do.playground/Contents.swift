//: Playground - noun: a place where people can play

import UIKit

let str = "Hello Playground"

do {
    let temp = "ABCDEF"
    print(str) // succeeds: it's in scope
}

print(temp) // fails: out of scope

// equivalent, really, to raw brackets in C
