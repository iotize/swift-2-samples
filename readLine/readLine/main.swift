//
//  main.swift
//  readLine
//
//  Created by Ryan Davies on 21/03/2016.
//  Copyright © 2016 Ryan Davies. All rights reserved.
//

import Foundation

print("What's your favorite color?")

if let colorReply = readLine() where !colorReply.isEmpty {
    print("Your favorite color is: \(colorReply)")
} else {
    print("You didn't reply with a favorite color :(")
}
