//
//  NumberFormatterExtensions.swift
//  Covid Spread World
//
//  Created by Fabrício Masiero on 12/04/20.
//  Copyright © 2020 Fabrício Masiero. All rights reserved.
//

import Foundation

extension NumberFormatter {
    public func citizens() -> NumberFormatter {
        self.numberStyle = .decimal
        self.locale = .current
        return self
    }
}
