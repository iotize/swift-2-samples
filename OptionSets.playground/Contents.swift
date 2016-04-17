//: Easier declaration
struct MyFontStyle : OptionSetType {
    let rawValue : Int
    static let Bold = MyFontStyle(rawValue: 1)
    static let Italic = MyFontStyle(rawValue: 2)
    static let Underline = MyFontStyle(rawValue: 3)
    static let Strikethrough = MyFontStyle(rawValue: 4)
}

//: Array-like syntax
let style: [MyFontStyle] = [
    .Bold,
    .Italic,
    .Underline
]

//: Easier checking
if style.contains(.Bold) {
    // do something
}
