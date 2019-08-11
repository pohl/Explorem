//  LoremParser.swift
//  SeinfeldChain
//
//  Created by pohl on 6/20/14.
//  Copyright (c) 2014 pohl. All rights reserved.
//

import Foundation
import StringScanner

let alphanumeric = CharactersSet.alphaNumeric
let whitespace = CharactersSet.space
let wordTerminators = CharactersSet.string(".,; ")

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

extension StringScanner {
    
    func advanceToNextWord() -> String? {
        return self.scan(untilCharacterSet: alphanumeric).toString()
    }
    
    func checkForPunctuation() -> Punctuation? {
        let string = self.scan(untilCharacterSet: whitespace).toString()
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
    
    func checkForNewParagraph() -> Bool {
        let whitespace = self.scan(untilCharacterSet:  alphanumeric).toString() ?? ""
        let hasNewline = whitespace.contains("\n")
        let length = whitespace.count
        let hasSpace = whitespace.contains(" ")
        return hasNewline
    }
    
    func checkForWord() -> Token? {
        let word = self.scan(untilCharacterSet: wordTerminators).toString()
        if let word = word {
            return Token.Word(word.lowercased())
        } else {
            return nil
        }
    }
    
    func nextPhrase() -> Phrase? {
        var result: [Token] = []
        var punctuation: Punctuation? = nil
        while punctuation == nil {
            let _ = self.advanceToNextWord()
            let word = self.scan(untilCharacterSet: wordTerminators).toString()
            if let word = word {
                result.append(Token.Word(word.lowercased()))
                punctuation = checkForPunctuation()
            } else {
                punctuation = Punctuation.None
            }
        }
        if let punctuation = punctuation {
            result.append(Token.Punctuation(punctuation.description))
            if punctuation == Punctuation.Semicolon {
                NSLog("hmm")
            }
        }
        return !result.isEmpty ? Phrase(fromTokens: result) : nil
    }
    
    func nextSentence() -> Sentence? {
        var phrases: [Phrase] = []
        var phrase: Phrase? = nil
        outerLoop: while true {
            phrase = nextPhrase()
            if let phrase = phrase {
                phrases.append(phrase)
                if phrase.isSentenceTerminator {
                    break outerLoop
                } else {
                    continue
                }
            } else {
                break outerLoop
            }
        }
        return phrases.count != 0 ? Sentence(fromPhrases: phrases) : nil
    }
    
    func nextParagraph() -> Paragraph? {
        var result: [Sentence] = []
        var foundNewParagraph = false
        while !foundNewParagraph {
            let sentence = self.nextSentence()
            if let sentence = sentence {
                result.append(sentence)
            }
            foundNewParagraph = checkForNewParagraph()
        }
        return !result.isEmpty ? Paragraph(fromSentences: result) : nil
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
    
    func parseParagraphs(string: String) -> [Paragraph] {
        let scanner = StringScanner(string: string)
        var paragraphs: [Paragraph] = []
        while true {
            if let paragraph = scanner.nextParagraph() {
                paragraphs.append(paragraph)
            } else {
                break
            }
        }
        return paragraphs
    }

    func readAllParagraphs() -> [Paragraph] {
        var paragraphs: [Paragraph] = []
        for i in 0...0 {
            let rawString = LoremParser.readLorem(index: i)!
            let moreParagraphs = self.parseParagraphs(string: rawString)
            paragraphs = paragraphs + moreParagraphs
        }
        return paragraphs
    }
}

extension ScannerResult {
    func toString() -> String? {
        switch self {
        case .end:
            return nil
        case .none:
            return nil
        case .value(let s):
            return s
        }
    }
}
