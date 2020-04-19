//
//  Summary.swift
//  Covid Spread World
//
//  Created by Fabrício Masiero on 11/04/20.
//  Copyright © 2020 Fabrício Masiero. All rights reserved.
//

import Foundation

public struct Summary: Codable {
    
    public let global: Global
    public var countries: [Country]
    
    public var filtered: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case global = "Global"
        case countries = "Countries"
    }
    public func country() -> String {
        if filtered == true {
            return countries.first?.country ?? ""
        }
        return "World"
    }
    public func totalDeaths() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = .current
        
        if filtered == true {
            return numberFormatter.string(from: NSNumber(integerLiteral: countries.first?.totalDeaths ?? 0)) ?? "0"
        }
        return numberFormatter.string(from: NSNumber(integerLiteral: global.totalDeaths)) ?? "0"
    }
    public func newDeaths() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = .current
        if filtered == true {
            return numberFormatter.string(from: NSNumber(integerLiteral: countries.first?.newDeaths ?? 0)) ?? "0"
        }
        return numberFormatter.string(from: NSNumber(integerLiteral: global.newDeaths)) ?? "0"
    }
    public func totalConfirmed() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = .current
        if filtered == true {
            return numberFormatter.string(from: NSNumber(integerLiteral: countries.first?.totalConfirmed ?? 0)) ?? "0"
        }
        return numberFormatter.string(from: NSNumber(integerLiteral: global.totalConfirmed)) ?? "0"
    }
    public func newConfirmed() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = .current
        if filtered == true {
            return numberFormatter.string(from: NSNumber(integerLiteral: countries.first?.newConfirmed ?? 0)) ?? "0"
        }
        return numberFormatter.string(from: NSNumber(integerLiteral: global.newConfirmed)) ?? "0"
    }
    public func totalRecovered() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = .current
        if filtered == true {
            return numberFormatter.string(from: NSNumber(integerLiteral: countries.first?.totalRecovered ?? 0)) ?? "0"
        }
        return numberFormatter.string(from: NSNumber(integerLiteral: global.totalRecovered)) ?? "0"
    }
    public func newRecovered() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = .current
        if filtered == true {
            return numberFormatter.string(from: NSNumber(integerLiteral: countries.first?.newRecovered ?? 0)) ?? "0"
        }
        return numberFormatter.string(from: NSNumber(integerLiteral: global.newRecovered)) ?? "0"
    }
    
}
