//
//  ViewModel.swift
//  RobotControls
//
//  Created by Andreas Ink on 8/11/23.
//

import SwiftUI
import Observation
import RealityKit
import ARKit

@Observable
class ViewModel {

    
    var state: ViewModelState
    var network: NetworkManager
    init(state: ViewModelState, network: NetworkManager) {
        self.state = state
        self.network = network
    }
    
    struct ViewModelState {
        var device: DeviceData
        var arView: ARView
        var simulation: SimulationState
        
        var roverEntity: ModelEntity?
        var obstaclesEntity: ModelEntity?
        var error: Error?
        static let startingState = ViewModelState(device: DeviceData(), arView: ARView(), simulation: SimulationState.rocks)
    }
    
    func initializeSimulation() {
        let box = MeshResource.generateBox(size: 5)
        
        let material = UnlitMaterial(color: .blue)
        state.roverEntity = ModelEntity(mesh: box, materials: [material])
        state.arView.session.run(ARWorldTrackingConfiguration(), options: [])
    }
    func updateSimulation() {
        Task {
            do {
                if let newSimState = try await network.postSimulationState(state.simulation) {
                    state.simulation = newSimState
                } else {
                    self.state.error = SimulationError(message: "Simulation is empty")
                }
            } catch {
                self.state.error = error
            }
        }
    }
    func moveRover(to position: IndexPath) {
        let position3D = Transform(translation: SIMD3<Float>(x: Float(position.row), y: 0, z: Float(position.section)))
       
        if let roverEntity = state.roverEntity {
            roverEntity.move(to: position3D, relativeTo: nil)
        }
    }
}

struct SimulationError: Error {
    var message: String
}
