//  LoremParser.swift
//  SeinfeldChain
//
//  Created by pohl on 6/20/14.
//  Copyright (c) 2014 pohl. All rights reserved.
//
import Foundation

let alphanumeric = NSCharacterSet.alphanumerics
let whitespace = NSCharacterSet.whitespacesAndNewlines
let comma = NSMutableCharacterSet(charactersIn: ",")
let wordTerminators = NSMutableCharacterSet(charactersIn: ".,; \n")

enum Punctuation {
    case Comma
    case Period
    case Semicolon
    case Unknown
    case None
    
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

extension Scanner {
    
    func advanceToNextWord() -> Bool {
        var buffer: NSString?  = nil
        return self.scanUpToCharacters(from: alphanumeric, into: &buffer)
    }
    
    func atPunctuation() -> Bool {
        var buffer: NSString?  = nil
        return self.scanUpToCharacters(from: alphanumeric, into: &buffer)
    }
    
    func checkForPunctuation() -> Punctuation? {
        var buffer: NSString?  = nil
        let foundCharacters = self.scanUpToCharacters(from: whitespace, into: &buffer)
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
            return nil
        }
    }
    
    func checkForWord() -> Token? {
        var buffer: NSString?  = nil
        let foundWord = self.scanUpToCharacters(from: wordTerminators as CharacterSet, into: &buffer)
        if foundWord {
            return Token.Word(buffer!.lowercased)
        } else {
            return nil
        }
    }
    
    func nextPhrase() -> ([Token],Punctuation)? {
        var result: [Token] = []
        var punctuation: Punctuation? = nil
        while punctuation == nil {
            let _ = self.advanceToNextWord()
            var buffer: NSString?  = nil
            let foundWord = self.scanUpToCharacters(from: wordTerminators as CharacterSet, into: &buffer)
            if foundWord {
                result.append(Token.Word(buffer!.lowercased))
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
        var phrases: [Phrase] = []
        var tuple: ([Token],Punctuation)? = nil
        outerLoop: while true {
            tuple = nextPhrase()
            if tuple != nil {
                let (wordTokens, punctuation) = tuple!
                var tokens: [Token] = wordTokens
                tokens.append(Token.Punctuation(punctuation.description))
                phrases.append(Phrase(fromTokens: tokens))
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
        return phrases.count != 0 ? Sentence(fromPhrases: phrases) : nil
    }

    
}


class LoremParser {
    
    @available(OSX 10.12, *)
    class func readLorem(index: Int) -> String? {
        
        let filename = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("Code")
            .appendingPathComponent("Explorem")
            .appendingPathComponent("Resources")
            .appendingPathComponent("loremipsum\(index).txt")
        var lorem: String? = nil
        do {
            lorem = try String(contentsOf: filename, encoding: String.Encoding.utf8)
        } catch {
            NSLog("yo")
        }
        return lorem
    }
    
    func parseSentences(string: String) -> [Sentence] {
        let scanner = Scanner(string: string)
        scanner.charactersToBeSkipped = nil
        var sentences: [Sentence] = []
        while true {
            if let sentence = scanner.nextSentence() {
                sentences.append(sentence)
            } else {
                break
            }
        }
        return sentences
    }

    @available(OSX 10.12, *)
    func readAllSentences() -> [Sentence] {
        var sentences: [Sentence] = []
        for i in 0...30 {            
            let rawString = LoremParser.readLorem(index: i)!
            let moreSentences = self.parseSentences(string: rawString)
            sentences = sentences + moreSentences
        }
        return sentences
    }
    
 }

