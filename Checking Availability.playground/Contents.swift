//: # Availability checking
//: At the time this was written, 9.3 was unreleased - so the first scope would not succeed.

if #available(iOS 10.0.0, *) {
    print("We're living in the future!")
} else {
    print("The version is lower than 10.0. Not there yet!")
}

if #available(iOS 9.2.0, *) {
    print("The version is 9.2 or higher.")
}

if #available(iOS 5.0.0, *) {
    print("The version is higher than 5.0 or higher")
}

/*:
It's not possible to specify the version as a variable :-(
This fails to build with "Expected version number"

    let version = "iOS 9.3.0"
    if #available(version, *) {
        print("Variables can be used as version numbers!")
    }

This fails to build with "statement cannot begin with a closure expression" - parser gets confused.

    let version = 9.3
    if #available(iOS version, *) {
        print("Variables can be used as version numbers!")
    }

*/
