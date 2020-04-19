//
//  SummaryError.swift
//  Covid Spread World
//
//  Created by Fabrício Masiero on 11/04/20.
//  Copyright © 2020 Fabrício Masiero. All rights reserved.
//

import Foundation

enum SummaryError: Error {
    case parsing(description: String)
    case network(description: String)
    case intern(description: String)
}
