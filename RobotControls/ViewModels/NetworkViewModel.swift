//
//  NetworkViewModel.swift
//  RobotControls
//
//  Created by Andreas Ink on 8/11/23.
//

import SwiftUI

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseURL = ""
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func getSimulationState() async throws -> SimulationState? {
        guard let url = URL(string: "\(baseURL)/get_state") else { throw NetworkError(message: "URL does not exist") }
   
        let (data, _) = try await URLSession.shared.data(from: url)
        let json = try decoder.decode(SimulationState.self, from: data)
        return json
    }
    
    func postSimulationState(_ state: SimulationState) async throws -> SimulationState? {
        guard let url = URL(string: "\(baseURL)/set_state") else { throw  NetworkError(message: "URL does not exist") }
       
        let inputData = try encoder.encode(state)
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.upload(for: request, from: inputData)
        let json = try decoder.decode(SimulationState.self, from: data)
        return json
    }
}
struct NetworkError: Error {
    var message: String
}
