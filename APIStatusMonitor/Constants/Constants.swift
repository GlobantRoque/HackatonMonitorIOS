//
//  Constants.swift
//  APIStatusMonitor
//
//  Created by Fidel Eduardo López Mayorga on 23/02/24.
//

struct Constants {
    static let updateInterval: Int = 300 // 5 minutes
    static let endpoints = [
        EndpointData(name: "All Characters", url: "https://hp-api.onrender.com/api/characters"),
        EndpointData(name: "Specify Character by ID", url: "https://hp-api.onrender.com/api/character/:id")
        // Añade más endpoints según sea necesario
    ]
}

struct EndpointData {
    let name: String
    let url: String
}
