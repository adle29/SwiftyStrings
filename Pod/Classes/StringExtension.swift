//
//  StringExtension.swift
//  SwiftyStrings
//  Created by Abraham Adberstein on 7/13/17.
//  Copyright © 2017 Abraham Adberstein. All rights reserved.
//

import Foundation

public extension String {
    
    func intToIndexRange(range:Range<Int>) -> Range<String.Index>{
        let fromIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: range.upperBound)
        return Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))
    }
    
    var is_numeric : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
    }
    
    func length()->Int{
        return self.characters.count
    }
    
    func getChar(_ index:Int) -> Character {
        return Array(self.characters)[index]
    }
    
    func hexStringToInt() -> UInt64 {
        if let val = UInt64(self, radix:16) { return val }
        else { return 0 }
    }
    
    func indexOf(of string: String, options: CompareOptions = .literal) -> Index? {
        let val = self.range(of: string, options: options)?.lowerBound
        return val
    }
    
    func split(_ pattern:String) -> [String] {
        return self.components(separatedBy: pattern)
    }
    
    func strstr(haystack:String, before_needle:Bool?=false) -> String {
        if let index = self.indexOf(of: haystack) {
            if(before_needle!){
                let ind = self.index(index, offsetBy: haystack.characters.count)
                return self.substring(to: ind)
            }
            else{
                return self.substring(from: index)
            }
        } else{
            return self
        }
    }
    
    func strrev() -> String {
        return String(self.characters.reversed())
    }
    
    func substr(from:Index, to:Index) -> String {
        return  self.substring(with: from..<to)
    }
    
    func substr(_ from:Int) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return self.substring(from: fromIndex)
        
    }
    
    func substr(_ from:Int, _ to:Int) -> String {
        if to < from { return ""}
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        let toIndex = self.index(self.startIndex, offsetBy: to)
        return self.substring(with: Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex)))
    }
    
    func substr(r: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        return self.substring(with: Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex)))
    }
    
    func substr_count(_ pattern:String) -> Int {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            if let result = regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.length())) {
                return result.numberOfRanges
            }
        } catch _ { return 0 }
        
        return 0
    }
    
    func str_replace(_ search:String, _ replace:String) -> String {
        return self.replacingOccurrences(of: search, with: replace)
    }
    
    func str_replace(_ searches:[String], _ replace:String) -> String {
        let string = NSMutableString(string:self)
        for search in searches {
            return self.replacingOccurrences(of: search, with: replace)
        }
        return string as String
    }
    
    func strpos(_ needle:String) -> Int{
        if let val = self.indexOf(of: needle) {
            return self.distance(from: self.startIndex, to: val)
        } else {
            return  -1
        }
    }
    
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func preg_match(_ pattern:String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            var matches = [String]()
            if let result = regex.firstMatch(in: self, options:[], range:  NSMakeRange(0, self.length())){
                for i in 0 ..< result.numberOfRanges {
                    let range = result.rangeAt(i)

                    if let r = range.toRange() {
                        matches.append(self.substr(r:r))
                    } else {
                        matches.append("")
                    }
                }
            }
            return matches
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func preg_replace(_ pattern:String, _ replace:String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let string = NSMutableString(string:self)
            regex.replaceMatches(in: string, options: [], range: NSMakeRange(0, self.length()), withTemplate: replace)
            return string as String
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return ""
        }
    }
    

    func preg_replace_callback(_ pattern:String, callback:(_ matches:[String]) -> [String]) -> String{
        var string = self
        string = string.preg_match_one_callback(pattern:"PA1\\*([^\\*]*[\\s])*\\*", str:string, callback: callback)
            
        return string
    }
    
    func preg_match_one_callback(pattern:String, str:String, callback:(_ matches:[String]) -> [String]) -> String {
        var string = str
        
        do {
            let regex = try NSRegularExpression(pattern: pattern)
        
            while let result = regex.firstMatch(in: string, options:[], range:  NSMakeRange(0, string.length())){
                print(result)
                let matches = getMatches(ranges: result, string: string)
                let replacements = callback(matches)
                print(1)
                for i in 0 ..< replacements.count {
                    if  i < result.numberOfRanges {
                        let range = result.rangeAt(i)
                        print(2)
                        if let r = range.toRange() {
                            print(3)
                            let r = self.intToIndexRange(range:r)
                            string.replaceSubrange(r, with:replacements[i])
                        }
                    }
                }
                print(4)
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
        }
        
        return string
    }
    
        
} //end string library

private func getMatches(ranges:NSTextCheckingResult, string:String) -> [String] {
    var matches = [String]()
    for i in 0..<ranges.numberOfRanges{
        if let r = ranges.rangeAt(i).toRange() {
             matches.append(string.substr(r: r))
        } else {
            matches.append("")
        }
    }
    return matches
}


