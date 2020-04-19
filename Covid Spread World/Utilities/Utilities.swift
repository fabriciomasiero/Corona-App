//
//  Utilities.swift
//  Covid Spread World
//
//  Created by Fabrício Masiero on 11/04/20.
//  Copyright © 2020 Fabrício Masiero. All rights reserved.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, SummaryError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}

