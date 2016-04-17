struct Person {
    let name: String
    let age: Int
    let friends: [Person]
}

func processPerson(person: Person) {
    func processFriends(friends: [Person]) {
        for friend in friends {
            processPerson(friend)
        }
    }
    
    processFriends(person.friends)
}

// This was invalid in Swift 1 - having a child function call its parent function.
