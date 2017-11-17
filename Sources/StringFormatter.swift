//
//  StringFormatter.swift
//  Zoomcar
//
//  Created by Gaurav Keshre on 16/02/17.
//  Copyright © 2017 Zoomcar. All rights reserved.
//

import Foundation

public enum TextFormat{
    case defaultCreditCard
    case custom(String)
    
    var regex : String{
        switch self {
        case .defaultCreditCard:
            return "#### #### #### #######"
            
        case .custom(let reg):
            return reg
        }
    }
}

public final class StringFormatter{
    private let regex: String
    private let placeholder: Character
    private var originalString: String!
 
    init(regex: String, placeholder: Character = "#") {
        self.regex = regex
        self.placeholder = placeholder
    }
    
    func normalizedString(from fancyString: String) -> String{
        let str = "\(placeholder)"
        let strRipped = regex.replacingOccurrences(of: str, with: "")
        let set = Set<Character>(strRipped.characters)
        return String(fancyString.characters.filter {!set.contains($0)})
    }
    
    
    /// This method first drops all the non placeholders from the string (Placeholder is the symbol introduced by the format you chose). Then loops through each character in the string and creates a new string. This method is optimized for cases when the regex is smaller than string.
    /// - Parameter string: the String that need to be transformed to passed in regex format.
    /// - Returns: (fancy:String, normal:String), tuple of final formatted and normal string
    
    func format(string: String) -> (fancy:String, normal:String){
        let string = normalizedString(from: string)
        
        guard string.characters.contains(placeholder) == false else{
            ///This case will be handled gracefully in future
            print("String contains the placeholder. Please choose a placeholder that is not present in the string.")
            return (string, "")
        }
        var finalString = ""
        var iR = 0 // arbitory on regex
        var iS = 0 // arbitory on String
        
        while iS < string.characters.count {
            if iR >= regex.characters.count{
                /// The regex has ended and we need to take the remaining string (starting from iS) as is.
                
                let strIndex = string.index(string.startIndex, offsetBy: iS)
                let rangee = strIndex ..< string.endIndex
                let sub = string.substring(with: rangee)
                finalString.append(sub)
                return (fancy: finalString, normal: string)
            }else if (regex[iR] == placeholder){
                finalString.append(string[iS] as Character)
                iS += 1 /// increment only when the character in inserted in `finalString`
            }else{
                finalString.append(regex[iR] as Character)
            }
            iR += 1
        }
        return (fancy: finalString, normal: string)
    }
}

fileprivate extension String {
    subscript (i: Int) -> Character {
        let index = self.index(self.startIndex, offsetBy: i)
        return self[index]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
}
