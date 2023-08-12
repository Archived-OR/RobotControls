//
//  RoverComponent.swift
//  RobotControls
//
//  Created by Andreas Ink on 8/11/23.
//

import SwiftUI
import RealityKit


struct RoverComponent: Component {
    var miningSpots: [Transform] // The mining spots the rover needs to go to
    var currentSpotIndex: Int = 0 // The index of the current mining spot
    var obstacles: [Entity] // The obstacles such as rocks or craters that the rover needs to avoid
}
