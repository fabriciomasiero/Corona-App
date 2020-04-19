//
//  APIClient.swift
//  Covid Spread World
//
//  Created by Fabrício Masiero on 11/04/20.
//  Copyright © 2020 Fabrício Masiero. All rights reserved.
//

import Foundation

public class APIClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}
