//
//  MainViewModel.swift
//  APIStatusMonitor
//
//  Created by Fidel Eduardo López Mayorga on 23/02/24.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var endpoints: [Endpoint] = []
    @Published var lastUpdated: String = ""
    @Published var nextUpdate: String = ""

    var endpointService = EndpointService()
    var timer: AnyCancellable?

    init() {
        scheduleUpdate()
    }

    func loadEndpoints() {
        endpointService.fetchEndpoints { [weak self] endpoints in
            DispatchQueue.main.async {
                self?.endpoints = endpoints
                self?.lastUpdated = self?.currentDateString() ?? ""
                self?.scheduleNextUpdate()
            }
        }
    }

    func scheduleUpdate() {
        let timeInterval = TimeInterval(Constants.updateInterval)
        timer = Timer.publish(every: timeInterval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.loadEndpoints()
            }
    }

    func scheduleNextUpdate() {
        let timeInterval = TimeInterval(Constants.updateInterval)
        let nextUpdateTime = Date().addingTimeInterval(timeInterval)
        nextUpdate = DateFormatter.localizedString(from: nextUpdateTime, dateStyle: .none, timeStyle: .short)
    }

    private func currentDateString() -> String {
        DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
    }
}
