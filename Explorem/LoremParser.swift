import Foundation

//  LoremParser.swift
//  SeinfeldChain
//
//  Created by pohl on 6/20/14.
//  Copyright (c) 2014 pohl. All rights reserved.
//
import Foundation

let alphanumeric = NSCharacterSet.alphanumericCharacterSet();
let whitespace = NSCharacterSet.whitespaceAndNewlineCharacterSet()
let comma = NSMutableCharacterSet(charactersInString: ",")
let wordTerminators = NSMutableCharacterSet(charactersInString: ".,; \n")

enum Punctuation: String {
    case Comma = "comma"
    case Period = "period"
    case Semicolon = "semicolon"
    case Unknown = "unknown"
    case None = "none"
    
    var description: String {
        switch self {
        case .Comma:
            return ","
        case .Period:
            return "."
        case .Semicolon:
            return ";"
        case .Unknown:
            return "[UNKNOWN]"
        case .None:
            return "[NONE]"
        }
    }
    
}

extension NSScanner {
    
    func advanceToNextWord() -> Bool {
        var buffer: NSString?  = nil
        return self.scanUpToCharactersFromSet(alphanumeric, intoString: &buffer)
    }
    
    func atPunctuation() -> Bool {
        var buffer: NSString?  = nil
        return self.scanUpToCharactersFromSet(alphanumeric, intoString: &buffer)
    }
    
    func checkForPunctuation() -> Punctuation? {
        var buffer: NSString?  = nil
        let foundCharacters = self.scanUpToCharactersFromSet(whitespace, intoString: &buffer)
        if foundCharacters {
            if "," == buffer {
                return Punctuation.Comma
            } else if "." == buffer {
                return Punctuation.Period
            } else if ";" == buffer {
                return Punctuation.Semicolon
            } else {
                return Punctuation.Unknown
            }
        } else {
            return nil;
        }
    }
    
    func checkForWord() -> Token? {
        var buffer: NSString?  = nil
        let foundWord = self.scanUpToCharactersFromSet(wordTerminators, intoString: &buffer)
        if foundWord {
            return Token.Word(buffer!.lowercaseString)
        } else {
            return nil
        }
    }
    
    func nextPhrase() -> ([Token],Punctuation)? {
        var result: [Token] = []
        var punctuation: Punctuation? = nil
        while !punctuation {
            self.advanceToNextWord()
            var buffer: NSString?  = nil
            let foundWord = self.scanUpToCharactersFromSet(wordTerminators, intoString: &buffer)
            if foundWord {
                result.append(Token.Word(buffer!.lowercaseString))
                punctuation = checkForPunctuation()
            } else {
                punctuation = Punctuation.None
            }
        }
        if 0 != result.count {
            return (result, punctuation!)
        } else {
            return nil
        }
    }
    
    func nextSentence() -> Sentence? {
        var tokens: [Token] = []
        var tuple: ([Token],Punctuation)? = nil
        outerLoop: while true {
            tuple = nextPhrase()
            if tuple {
                let (phrase, punctuation) = tuple!
                tokens = tokens + phrase
                tokens.append(Token.Punctuation(punctuation.description))
                switch punctuation {
                case .Comma:
                    continue
                default:
                    break outerLoop
                }
            } else {
                break outerLoop
            }
        }
        return tokens.count != 0 ? Sentence(fromTokens: tokens) : nil
    }

    
}


class LoremParser {
    
    class func readLorem(index: Int) -> String? {
        var error: NSError? = nil
        var lorem: String? = String.stringWithContentsOfFile("loremipsum\(index).txt", encoding: NSUTF8StringEncoding, error: &error)
        return lorem
    }
    
    func parseSentences(string: String) -> [Sentence] {
        let scanner = NSScanner(string: string)
        var buffer: NSString?  = nil
        scanner.charactersToBeSkipped = nil
        var sentences: [Sentence] = []
        while true {
            if let sentence = scanner.nextSentence() {
                sentences.append(sentence)
            } else {
                break;
            }
        }
        return sentences
    }
    
    func readAllSentences() -> [Sentence] {
        var sentences: [Sentence] = []
        for i in 0...15 {
            var rawString = LoremParser.readLorem(i)!
            let moreSentences = self.parseSentences(rawString)
            sentences = sentences + moreSentences
        }
        return sentences
    }
    
 }

