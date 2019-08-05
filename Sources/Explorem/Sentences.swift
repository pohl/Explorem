//
//  File.swift
//  
//
//  Created by Pohl on 8/4/19.
//

import Foundation

let cannedSentences = [
    Sentence(fromTokens: loremIpsum),
    Sentence(fromTokens: interdumEt),
    Sentence(fromTokens: cumSociis),
    Sentence(fromTokens: pellentesqueHabitant),
    Sentence(fromTokens: classAptent),
    Sentence(fromTokens: nullaFacilisi),
    Sentence(fromTokens: vestibulumAnte),
    Sentence(fromTokens: suspendissePotenti),
    Sentence(fromTokens: aliquamErat),
    Sentence(fromTokens: inHac),
]

private let loremIpsum:[Token] = [
    .Word("lorem"),
    .Word("ipsum"),
    .Word("dolor"),
    .Word("sit"),
    .Word("amet"),
    .Punctuation(","),
    .Word("consectetur"),
    .Word("adipiscing"),
    .Word("elit"),
    .Punctuation("."),
]

private let interdumEt:[Token] = [
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
]

private let cumSociis:[Token] = [
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
    .Word("nascetur"),
    .Word("ridiculus"),
    .Word("mus"),
    .Punctuation("."),
]

private let pellentesqueHabitant:[Token] = [
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
]

private let classAptent:[Token] = [
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
    .Word("per"),
    .Word("inceptos"),
    .Word("himenaeos"),
    .Punctuation("."),
]

private let nullaFacilisi:[Token] = [
    .Word("nulla"),
    .Word("facilisi"),
    .Punctuation("."),
]

private let vestibulumAnte:[Token] = [
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
]

private let suspendissePotenti:[Token] = [
    .Word("suspendisse"),
    .Word("potenti"),
    .Punctuation("."),
]

private let aliquamErat:[Token] = [
    .Word("aliquam"),
    .Word("erat"),
    .Word("volutpat"),
    .Punctuation("."),
]

private let inHac:[Token] = [
    .Word("in"),
    .Word("hac"),
    .Word("habitasse"),
    .Word("platea"),
    .Word("dictumst"),
    .Punctuation("."),
]
