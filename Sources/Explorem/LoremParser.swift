//  LoremParser.swift
//  SeinfeldChain
//
//  Created by pohl on 6/20/14.
//  Copyright (c) 2014 pohl. All rights reserved.
//
import Foundation

let alphanumeric = CharacterSet.alphanumerics
let whitespace = CharacterSet.whitespacesAndNewlines
let comma = CharacterSet(charactersIn: ",")
let wordTerminators = CharacterSet(charactersIn: ".,; ")
//let paragraphTerminators = CharacterSet(charactersIn: "\n")

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

@available(OSX 10.15, *)
extension Scanner {
    
    func advanceToNextWord() -> String? {
        return self.scanUpToCharacters(from: alphanumeric)
    }
    
    func atPunctuation() -> String? {
        return self.scanUpToCharacters(from: alphanumeric)
    }
    
    func checkForPunctuation() -> Punctuation? {
        let string = self.scanUpToCharacters(from: whitespace)
        if let string = string {
            if "," == string {
                return Punctuation.Comma
            } else if "." == string {
                return Punctuation.Period
            } else if ";" == string {
                return Punctuation.Semicolon
            } else {
                return Punctuation.Unknown
            }
        } else {
            return nil
        }
    }
    
    func checkForWord() -> Token? {
        let word = self.scanUpToCharacters(from: wordTerminators)
        if let word = word {
            return Token.Word(word.lowercased())
        } else {
            return nil
        }
    }
    
    func nextPhrase() -> ([Token],Punctuation)? {
        var result: [Token] = []
        var punctuation: Punctuation? = nil
        while punctuation == nil {
            let _ = self.advanceToNextWord()
            let word = self.scanUpToCharacters(from: wordTerminators)
            if let word = word {
                result.append(Token.Word(word.lowercased()))
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


@available(OSX 10.15, *)
class LoremParser {
    
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

