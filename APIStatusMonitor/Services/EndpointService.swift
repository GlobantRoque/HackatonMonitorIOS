//
//  EndpointService.swift
//  APIStatusMonitor
//
//  Created by Fidel Eduardo López Mayorga on 23/02/24.
//

import Foundation

class EndpointService {
    let apiManager = APIManager()
    
    func fetchEndpoints(completion: @escaping ([Endpoint]) -> Void) {
        let dispatchGroup = DispatchGroup()
        var endpoints: [Endpoint] = []
        for endpoint in Constants.endpoints {
            dispatchGroup.enter()
            self.apiManager.fetchData(from: endpoint.url) { success in
                endpoints.append(Endpoint(name: endpoint.name, url: endpoint.url, isActive: success))
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion(endpoints)
        }
    }
}

class APIManager {
    func fetchData(from endpoint: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(false)
            return
        }
        URLSession.shared.dataTask(with: url) { _, response, error in
            if let _ = error {
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(false)
                return
            }
            let success = (200...299).contains(httpResponse.statusCode)
            completion(success)
        }.resume()
    }
}
