import Foundation

//: # Example 1
//: Extended from https://www.natashatherobot.com/swift-2-pattern-matching-with-if-case/

enum SignUpFormField {
    case FirstName(String)
    case LastName(String)
    case EmailAddress(String)
    case DOB(NSDate)
}

let taylorSwiftsBday: NSDate = {
    let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    let dateComponents = NSDateComponents()
    dateComponents.day = 13
    dateComponents.month = 12
    dateComponents.year = 1989
    return gregorianCalendar?.dateFromComponents(dateComponents) ?? NSDate()
}()

/*:
## Pre Swift 2

    func bornBeforeTaylorSwift(signUpFormField: SignUpFormField) {
        switch signUpFormField {
        case .DOB(let otherBday)
            where taylorSwiftsBday.compare(otherBday) == .OrderedDescending:
            print("Fun fact: You were born before Taylor Swift!")
        default:
            break
        }
    }

## Post Swift 2
*/

extension NSDate : Comparable {}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

extension NSDate {
    func isEarlierThan(otherDate: NSDate) -> Bool {
        return self > otherDate
    }
    
    func isLaterThan(otherDate: NSDate) -> Bool {
        return self < otherDate
    }
}

func bornBeforeTaylorSwift(signUpFormField: SignUpFormField) {
    if case .DOB(let otherBday) = signUpFormField
        where taylorSwiftsBday.isEarlierThan(otherBday)
    {
        print("Fun fact: You were born before Taylor Swift!")
    }
}

bornBeforeTaylorSwift(.DOB(NSDate(timeIntervalSince1970: 0)))

//: # Example 2

enum SegueIdentifier : String {
    case ShowFavorites = "ShowFavorites"
    case ShowHistory   = "ShowHistory"
    case ShowAddItem   = "ShowAddItem"
}

let identifier = SegueIdentifier.ShowAddItem

switch identifier {
case .ShowAddItem:
    print("show add item")
default:
    print("this is redundant")
}

if identifier == SegueIdentifier.ShowAddItem {
    // to avoid this (which wouldn't work when there are enum attributes)
}

// we can do this:

if case .ShowAddItem = identifier {
    print("show add item")
}

// normal pattern matching applies.
