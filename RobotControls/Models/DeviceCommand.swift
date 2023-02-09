//
//  DeviceCommand.swift
//  RobotControls
//
//  Created by Andreas Ink on 2/8/23.
//

import SwiftUI

enum DeviceCommand: String {
    case forward = "movement_forward"
    case back = "movement_back"
    
    case left = "movement_left"
    case right = "movement_right"
    
    case rotate = "stepper_rotate"
    case stopRotate = "stepper_stop"
    
}
