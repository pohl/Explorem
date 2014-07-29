//
//  main.swift
//  Explorem
//
//  Created by Pohl Longsine on 7/27/14.
//  Copyright (c) 2014 the screaming organization. All rights reserved.
//

import Foundation

func run() -> () {
    let parser = LoremParser()
    let sentences: [Sentence] = parser.readAllSentences()
    let elapsed = stopwatch {
        var sentenceCounts = Multiset<Sentence>()
        var phraseCounts = Multiset<Phrase>()
        var wordCounts = Multiset<Word>()
        for sentence in sentences {
            sentenceCounts.add(sentence)
            for phrase in sentence.phrases {
                phraseCounts.add(phrase)
                for word in phrase.words {
                    wordCounts.add(word)
                }
            }
        }
        //            for (key, value) in sentenceCounts {
        //                if value != 1 {
        //                    println("\(value) occurrences of sentence \(key)")
        //                }
        //            }
        //            for (key, value) in phraseCounts {
        //                if value != 1 {
        //                    println("\(value) occurrences of phrase: \(key)")
        //                }
        //            }
        
        for (key, value) in wordCounts {
            if value != 0 {
                println("\(value) occurrences of word: \(key)")
            }
        }
    }
    println("elapsed == \(elapsed)")
}

run()



