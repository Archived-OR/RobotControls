//
//  DeviceDtaa.swift
//  RobotControls
//
//  Created by Andreas Ink on 2/8/23.
//

import SwiftUI
import CoreBluetooth

struct DeviceData {
    var id = UUID()
    var name = ""
    var components = [RoverComponent]()
    var peripheral: CBPeripheral?
}
