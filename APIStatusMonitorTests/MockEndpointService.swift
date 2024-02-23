//
//  MockEndpointService.swift
//  APIStatusMonitorTests
//
//  Created by Angel Olvera on 23/02/24.
//

import XCTest
@testable import APIStatusMonitor

class MockEndpointService: EndpointService {
    let mockEndpoints: [Endpoint]
    
    init(endpoints: [Endpoint] = []) {
        self.mockEndpoints = endpoints
    }
    
    override func fetchEndpoints(completion: @escaping ([Endpoint]) -> Void) {
        completion(mockEndpoints)
    }
}
