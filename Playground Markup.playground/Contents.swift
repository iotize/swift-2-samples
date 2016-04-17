/*:

# Playground Markup

## Toggling Documentation

Playgrounds can either be rendered as raw content (the format you want if you're _writing_ Markup) or rendered with documentation (the format you want if you're _reading_ Markup).

The feature is located in two locations.

The first is in the status bar menu:

![](show_raw.png "Editor -> Show Raw Markup")

The title changes depending on which mode you're in. If you're looking at raw markup, it'll say "Show Rendered Markup".

The other location is in the sidebar, so make sure the utility bar is showing in Xcode (press ⎇⌘0):

![](render_docs.png "Utility Bar -> Render Documentation checkbox")

## Writing Documentation

Comments beginning only with '//' (standard single-line comments) don't get rendered as documentation.

Single lines can be made into documentation by appending the key character ':' to make the line prefix //:, e.g:

\/\/\: Hello World

Similarly, multiline comments must be formatted with the key character ':', e.g:

\/\*:

Example Comment

\*\/


----


## Line Formatting Commands

### Lists

Bulleted list are written using an asterisk for each bullet. E.g:
* Point One
* Point Two
* Point Three

Numbered lists are written using numbers followed by periods. E.g:
1. Point One
2. Point Two
3. Point Three

The first index of a numbered list can be changed, but subsequent points essentially ignore their assigned number and instead use the previous index incremented by 1. One downside of this is that it isn't possible to have numbered lists that go backwards, but that probably isn't a very common requirement:

0. Point 0
1. Point 1
2. Point 2



10. Point 10
11. Point 11
12. Point 12



3. Point 3
2. Point 2
1. Point 1



9. Point 9
7. Point 7
5. Point 5

### Code Blocks

There are two formats for code blocks. The first uses indentation, and the second uses backticks.

To use indendation, prefix each line of code with four spaces:

for character in "Bradbury" {
println(character)
}

Fenced code blocks (using backticks) are valid Markup syntax according to [Apple](https://developer.apple.com/library/ios/documentation/Xcode/Reference/xcode_markup_formatting_ref/CodeBlocks.html#//apple_ref/doc/uid/TP40016497-CH12-SW1) but only work when used for symbol documentation - not in playgrounds.

E.g:

````
for character in "Bradbury" {
println(character)
}
````

### Block Quotes

Block quotes are indicated by lines beginning with the > symbol:

> “I think it’s the Myrmidone cluster that goes out past Mars and in toward Earth once every five years. I’m right in the middle. It’s like a big kaleidoscope. You get all kinds of colors and shapes and sizes. God, it’s beautiful, all that metal.”

From _Kaleidoscope_ by Ray Bradbury

### Headings

Headings are written with # as a prefix:

# Heading 1

## Heading 2

### Heading 3

#### Heading 4

##### Heading 5

And can also be written with equals signs beneath to get the equivalent of a top-level heading:

Heading 1
=========

Second-level headings can be written with dashes:

Heading 2
---------

Use whichever is preferable.

### Horizontal Rules

Four or more dashes surrounded by whitespace create a horizontal rule:


----


### Link References

Link references allow for reusing the same URL across multiple references, e.g:

[The Swift Programming Language]: http://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ "Some hover text"

For light reading we suggest [The Swift Programming Language].

For more information, see [The Swift Programming Language].

If you are not sure, please see [The Swift Programming Language].


----


## Text Formatting Commands

### Styling Text

Code can be rendered as part of a comment by using backticks, e.g: `for` is written as \`for\`.

_Italic text_ is designated with either a single set of underscores or asterisks: \_italic\_ or \*italic\*.

**Bold text** is designated with either a double set of underscores or asterisks: \_\_asterisks\_\_ or \*\*bold\*\*.

### Escaping Symbols

Several characters are used for Markup syntax, but it's possible that might interfere with your writing. For that reason, symbols can be escaped with a backslash:

\_Italic Text\_

\*\*Bold Text\*\*

\* Point One

### Images

Images can be embedded using the syntax \!\[alternate text\]\(URL \"hover title\"\)

URL's can be local (no path indicates to look within the playground's Resources folder), or remote:

![seesaw](http://devimages.apple.com.edgekey.net/swift/images/playgrounds.png "Seesaw")

GIFs can also be embedded:

![Example GIF](sample_gif.gif "Example GIF")

### Links

Links to web resources are added with the syntax \[text\]\(URL\), e.g: [Swift](http://developer.apple.com/swift/)

## Page Navigation

Playground pages can link to previous, next, and specific pages.

Previous pages are linked using the syntax: \[Previous\]\(@previous\)

Next pages are linked using the syntax: \[Next\]\(@next\)

Specific pages are linked using the syntax: \[Specific Page\]\(Specific%20Page%20Name\)

%20 must be used in place of the space character in the target page name when creating a specific page link.

[Next](@next)

*/
