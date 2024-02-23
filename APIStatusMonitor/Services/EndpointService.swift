//
//  EndpointService.swift
//  APIStatusMonitor
//
//  Created by Fidel Eduardo López Mayorga on 23/02/24.
//

import Foundation

class EndpointService {
    func fetchEndpoints(completion: @escaping ([Endpoint]) -> Void) {
        //TODO: reemplazar con llamada a API real
        let endpoints = Constants.endpoints.map { Endpoint(name: $0.name, url: $0.url, isActive: false) }
        completion(endpoints)
    }
}
