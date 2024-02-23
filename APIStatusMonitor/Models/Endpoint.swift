//
//  Endpoint.swift
//  APIStatusMonitor
//
//  Created by Fidel Eduardo López Mayorga on 23/02/24.
//

import Foundation

struct Endpoint: Identifiable {
    let id = UUID()
    var name: String
    var url: String
    var isActive: Bool
}
