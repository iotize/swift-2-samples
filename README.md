# @nonobjc

This is an example of using the `@nonobjc` attribute added in Swift 2.

Take a look at `Squirrel.m` and `Rabbit.swift` for an example of `@nonobjc`.

`[Rabbit hop]` is unmarked by attributes, so is available to `Squirrel`. However, `[Rabbit wiggleEars]` is marked `@nonobjc` - so trying to access it from Objective-C causes compilation to fail.