//
//  CovidData.swift
//  Practica 8 (Covid)
//
//  Created by Ingrid on 03/12/20.
//

import Foundation

struct CovidData: Codable {
    let country: String
    let countryInfo: CountryInfo
    let cases: Double
    let deaths: Double
}

struct CountryInfo: Codable {
    let flag: URL
}
