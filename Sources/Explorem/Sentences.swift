//
//  File.swift
//  
//
//  Created by Pohl on 8/4/19.
//

import Foundation

let cannedSentences = [
    Sentence(fromPhrases: loremIpsum),
    Sentence(fromPhrases: interdumEt),
    Sentence(fromPhrases: cumSociis),
    Sentence(fromPhrases: pellentesqueHabitant),
    Sentence(fromPhrases: classAptent),
    Sentence(fromPhrases: nullaFacilisi),
    Sentence(fromPhrases: vestibulumAnte),
    Sentence(fromPhrases: suspendissePotenti),
    Sentence(fromPhrases: aliquamErat),
    Sentence(fromPhrases: inHac),
]

private let loremIpsum:[Phrase] = [
    Phrase(fromTokens: [
        .Word("lorem"),
        .Word("ipsum"),
        .Word("dolor"),
        .Word("sit"),
        .Word("amet"),
        .Punctuation(","),
        ]),
    Phrase(fromTokens: [
        .Word("consectetur"),
        .Word("adipiscing"),
        .Word("elit"),
        .Punctuation("."),
    ]),
]

private let interdumEt:[Phrase] = [
    Phrase(fromTokens: [
        .Word("interdum"),
        .Word("et"),
        .Word("malesuada"),
        .Word("fames"),
        .Word("ac"),
        .Word("ante"),
        .Word("ipsum"),
        .Word("primis"),
        .Word("in"),
        .Word("faucibus"),
        .Punctuation("."),
    ]),
]

private let cumSociis:[Phrase] = [
    Phrase(fromTokens: [
        .Word("cum"),
        .Word("sociis"),
        .Word("natoque"),
        .Word("penatibus"),
        .Word("et"),
        .Word("magnis"),
        .Word("dis"),
        .Word("parturient"),
        .Word("montes"),
        .Punctuation(","),
    ]),
    Phrase(fromTokens: [
        .Word("nascetur"),
        .Word("ridiculus"),
        .Word("mus"),
        .Punctuation("."),
    ]),
]

private let pellentesqueHabitant:[Phrase] = [
    Phrase(fromTokens: [
        .Word("pellentesque"),
        .Word("habitant"),
        .Word("morbi"),
        .Word("tristique"),
        .Word("senectus"),
        .Word("et"),
        .Word("netus"),
        .Word("et"),
        .Word("malesuada"),
        .Word("fames"),
        .Word("ac"),
        .Word("turpis"),
        .Word("egestas"),
        .Punctuation("."),
    ]),
]

private let classAptent:[Phrase] = [
    Phrase(fromTokens: [
        .Word("class"),
        .Word("aptent"),
        .Word("taciti"),
        .Word("sociosqu"),
        .Word("ad"),
        .Word("litora"),
        .Word("torquent"),
        .Word("per"),
        .Word("conubia"),
        .Word("nostra"),
        .Punctuation(","),
    ]),
    Phrase(fromTokens: [
        .Word("per"),
        .Word("inceptos"),
        .Word("himenaeos"),
        .Punctuation("."),
    ]),
]

private let nullaFacilisi:[Phrase] = [
    Phrase(fromTokens: [
        .Word("nulla"),
        .Word("facilisi"),
        .Punctuation("."),
    ]),
]

private let vestibulumAnte:[Phrase] = [
    Phrase(fromTokens: [
        .Word("vestibulum"),
        .Word("ante"),
        .Word("ipsum"),
        .Word("primis"),
        .Word("in"),
        .Word("faucibus"),
        .Word("orci"),
        .Word("luctus"),
        .Word("et"),
        .Word("ultrices"),
        .Word("posuere"),
        .Word("cubilia"),
        .Word("curae"),
        .Punctuation(";"),
    ]),
]

private let suspendissePotenti:[Phrase] = [
    Phrase(fromTokens: [
        .Word("suspendisse"),
        .Word("potenti"),
        .Punctuation("."),
    ]),
]

private let aliquamErat:[Phrase] = [
    Phrase(fromTokens: [
        .Word("aliquam"),
        .Word("erat"),
        .Word("volutpat"),
        .Punctuation("."),
    ]),
]

private let inHac:[Phrase] = [
    Phrase(fromTokens: [
        .Word("in"),
        .Word("hac"),
        .Word("habitasse"),
        .Word("platea"),
        .Word("dictumst"),
        .Punctuation("."),
    ]),
]
