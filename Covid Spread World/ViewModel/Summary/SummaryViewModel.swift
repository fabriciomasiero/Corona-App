//
//  SummaryViewModel.swift
//  Covid Spread World
//
//  Created by Fabrício Masiero on 11/04/20.
//  Copyright © 2020 Fabrício Masiero. All rights reserved.
//

import SwiftUI
import Combine

class SummaryViewModel: ObservableObject, Identifiable {
    
    private let summaryClient: SummaryClient
    
    private var disposables = Set<AnyCancellable>()
    
    @Published var summary: Summary?
    
    var persistentSummary: Summary?
    
    init(summaryClient: SummaryClient, scheduler: DispatchQueue = DispatchQueue(label: "SummaryViewModel")) {
        self.summaryClient = summaryClient
        getSummary()
    }
    func getSummary() {
        summaryClient.getSummary().map { response in
            let countries = response.countries.sorted(by: { $0.totalConfirmed > $1.totalConfirmed })
            var sortedSummary = response
            sortedSummary.countries = countries
            DispatchQueue.main.async {
                self.summary = sortedSummary
                self.persistentSummary = sortedSummary
            }
        }.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("completed")
                }
        }) {()}.store(in: &disposables)
    }
    
    public func search(text: String) {
        if text.count >= 2 {
            guard let summary = persistentSummary else {
                return
            }
            let countries = summary.countries.filter({ $0.country.lowercased().contains(text.lowercased())})
            var newSummary = summary
            newSummary.filtered = true
            newSummary.countries = countries
            self.summary = newSummary
            return
        }
        var newSummary = persistentSummary
        newSummary?.filtered = false
        self.summary = newSummary
    }
    public func setCountry(_ country: Country) {
        guard let summary = persistentSummary else {
            return
        }
        var newSummary = summary
        newSummary.filtered = true
        newSummary.countries = [country]
        self.summary = newSummary
    }
}

