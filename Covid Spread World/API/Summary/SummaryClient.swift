//
//  SummaryClient.swift
//  Covid Spread World
//
//  Created by Fabrício Masiero on 11/04/20.
//  Copyright © 2020 Fabrício Masiero. All rights reserved.
//

import Foundation
import Combine

protocol SummaryFeatchable {
    func getSummary() -> AnyPublisher<Summary, SummaryError>
}

class SummaryClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension SummaryClient: SummaryFeatchable {
    func getSummary() -> AnyPublisher<Summary, SummaryError> {
        func summaryUrl() -> URLRequest? {
            guard let url = URL(string: "https://api.covid19api.com/summary") else {
                  return nil
              }
            return URLRequest(url: url)
        }
        return summary(urlRequest: summaryUrl())
    }
    
    private func summary<T>(urlRequest: URLRequest?) -> AnyPublisher<T, SummaryError> where T : Decodable {
        guard let urlRequest = urlRequest else {
            let error = SummaryError.intern(description: "Couldnt create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: urlRequest).mapError { error in
            .network(description: error.localizedDescription)
        }.flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
        }.eraseToAnyPublisher()
    }
    
//    func getSummary() -> AnyPublisher<[String], String> {
//        return IDEUpdates(urlRequest: xcodeReleasesURL())
//    }
//
//    private func IDEUpdates<T>(urlRequest: URLRequest?) -> AnyPublisher<T, XcodeUpdatesError> where T : Decodable {
//        guard let urlRequest = urlRequest else {
//            let error = XcodeUpdatesError.intern(description: "Couldnt create URL")
//            return Fail(error: error).eraseToAnyPublisher()
//        }
//        return session.dataTaskPublisher(for: urlRequest).mapError { error in
//            .network(description: error.localizedDescription)
//        }.flatMap(maxPublishers: .max(1)) { pair in
//            decode(pair.data)
//        }.eraseToAnyPublisher()
//    }
}

