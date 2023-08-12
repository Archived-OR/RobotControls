//
//  SimulationState.swift
//  RobotControls
//
//  Created by Andreas Ink on 8/11/23.
//

import SwiftUI

struct SimulationState: Codable {
    enum SimulationType: String, Codable {
        case rocks
        case craters
        case all
        case custom
    }
    var simulationID: String
    var type: SimulationType
    var obstacles: [IndexPath]
    var startingPosition: IndexPath
    var nextMiningPosition: IndexPath
    var currentPosition: IndexPath?
    static let rocks = SimulationState(simulationID: UUID().uuidString, type: .rocks, obstacles: [], startingPosition: .random, nextMiningPosition: .random)
    static let divots = SimulationState(simulationID: UUID().uuidString, type: .craters, obstacles: [], startingPosition: .random, nextMiningPosition: .random)
    static let all = SimulationState(simulationID: UUID().uuidString, type: .all, obstacles: [], startingPosition: .random, nextMiningPosition: .random)
}

extension IndexPath {
    static let random = IndexPath(row: .random(in: 0...5), section: .random(in: 0...5))
}
