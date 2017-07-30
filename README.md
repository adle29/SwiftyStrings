SwiftyStrings
============

SwiftyStrings is simple string manipulation extenson for Swift. The purpose of this library is to translate useful PHP string methods to Swift.

## Contribution

Please feel free to contribute to the project. The goal is to convert as many useful php string methods into Swift methods in order to ease the complexity of the Swift string manipulaiton API. 

## Installation

SwiftyStrings is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftyStrings"
```

## Usage

```swift
import SwiftyStrings
```

## Methods

**is_numeric()**
```swift
"1".is_numeric() // True
```
**length()**
```swift
"Hello World".length() // 11
```

**getChar()**
```swift
"Captian America".getChar(0) // C
```

**hexStringToInt()**
```swift
"A".hexStringToInt(0) // 10
```

**split()**
```swift
"sushi,tacos,ramen".split(",") // ["sushi", "tacos", "ramen"]
```

**indexOf()**
```swift
"Life is like a box of chocolates.".indexOf(of: "box") // Swift.String.CharacterView.Index(_base: Swift.String.UnicodeScalarView.Index(_position: 15), _countUTF16: 1)
```

**strstr()**
```swift
"Life is like a box of chocolates.".strstr(haystack: "box") // box of chocolates.
"Life is like a box of chocolates.".strstr(haystack: "box", before_needle: true) // Life is like a box
```

**strrev()**
```swift
"Roses are Red."strrev() // .deR era sesoR
```

**substr()**
```swift
"To be or not to be- that is the question.".substr(9) // not to be- that is the question.
"To be or not to be- that is the question.".substr(9,13) //not
"To be or not to be- that is the question.".substr(r: 9..<13) //not
```

**substr_count()**
```swift
"RedRedYellowRedBlue".substr_count("(Red)[\\w]*(Red)" \\ 3
```

**str_replace()**
```swift
"Make war.".str_replace("war", "love") \\ "Make love."
```

**strpos()**
```swift
"A Yellow Submarine.".strpos("Submarine") \\ 9
```

**preg_match()**
```swift
"RedRedYellowRedBlue".preg_match("(Red)[\\w]*(Red)") \\ ["RedRedYellowRed", "Red", "Red"]
```

**preg_replace()**
```swift
"RedRedYellowRedBlue".preg_replace("(Red)", "Blue") \\ BlueBlueYellowBlueBlue
```

**preg_match_one_callback()**
```swift
"RedRedYellowRedBlue".preg_replace_callback("(Red)[\\w]*(Red)") { (matches) -> [String] in
    return [matches[0].str_replace("Red", "Bed")]
} // BedBedYellowBedBlue
```
