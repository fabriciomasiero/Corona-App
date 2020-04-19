//
//  Country.swift
//  Covid Spread World
//
//  Created by Fabrício Masiero on 11/04/20.
//  Copyright © 2020 Fabrício Masiero. All rights reserved.
//

import Foundation

public struct Country: Codable {
    let country: String
    let code: String
    let slug: String
    let newConfirmed: Int
    let totalConfirmed: Int
    let newDeaths: Int
    let totalDeaths: Int
    let newRecovered: Int
    let totalRecovered: Int
    let lastUpdate: String
    
    private enum CodingKeys: String, CodingKey {
        case country = "Country"
        case code = "CountryCode"
        case slug = "Slug"
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
        case lastUpdate = "Date"
    }
    
    public func confirmed() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = .current
        return numberFormatter.string(from: NSNumber(integerLiteral: totalConfirmed)) ?? "0"
    }
}
