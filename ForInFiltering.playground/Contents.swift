import Foundation

//: For ... in filtering with value types

let primeNumbers = [1, 2, 3, 5, 7, 11, 13, 17]
for number in primeNumbers where number < 10 {
    print("Less than 10: \(number)")
}

//: For ... in filtering with ranges!

let oneToNine = 1..<10
let oneToTen = 1...10

for number in 1..<10 where number % 2 == 0 {
    print("Even: \(number)")
}

//: frankly though this is easier to express with `filter`:
let evenNumbers = (1..<10).filter { $0 % 2 == 0 }
print(evenNumbers)

//: For ... in filtering with properties

struct Dog {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let dogs = [
    Dog(name: "Pooch", age: 1),
    Dog(name: "Spot", age: 1),
    Dog(name: "Scruffy", age: 11)
]

for puppy in dogs where puppy.age == 1 {
    print("\(puppy.name) is a puppy.")
}

//: For ... in filtering with enums
//: arguably the most useful case

enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

let barcodes: [Barcode] = [
    .UPCA(8, 85909, 51226, 3),
    .QRCode("ABCDEFGHIJKLMNOP"),
    .QRCode("QRSTUVWXYZ"),
    .QRCode("ABCDEFGHIQ")
]

for case .QRCode(let productCode) in barcodes {
    print("QR product code: \(productCode)")
}

for case .QRCode(let productCode) in barcodes where productCode.containsString("Q") {
    print("QR code with 'Q' in: \(productCode)")
}
