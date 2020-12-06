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
    let recovered: Double
    let active: Double
    let critical: Double
    let population: Double
    let todayCases: Double
    let todayDeaths: Double
    let todayRecovered: Double
}

struct CountryInfo: Codable {
    let flag: URL
}
