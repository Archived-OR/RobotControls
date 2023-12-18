//
//  BLEViewModel.swift
//  RobotControls
//
//  Created by Andreas Ink on 2/8/23.
//

import SwiftUI
import CoreBluetooth

class BluetoothViewModel: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    @Published var components = Component.all
    @Published var manager = CBCentralManager()
    @Published var pairedDevice: CBPeripheral? = nil
    @Published var pairedCharacteristic: CBCharacteristic? = nil
    func start() {
        manager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        
    }
    @Published var devices = [DeviceData]()
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: [])
        }
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let name = peripheral.name {
            if name == "SH-HC-08" {
                devices.append(DeviceData(name: name))
                
                manager.connect(peripheral)
                Task { @MainActor in
                    pairedDevice = peripheral
                    peripheral.delegate = self
                }
            }
            
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        pairedDevice = peripheral
        print("connected")
        
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        if let services = peripheral.services {
            
            
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
                if let pairedCharacteristic = service.characteristics?.first {
                    self.pairedCharacteristic = pairedCharacteristic
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error discovering descriptors: \(error.localizedDescription)")
            return
        }
        
        
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        if let services = peripheral.services {
            for service in services {
                
                peripheral.discoverCharacteristics([CBUUID(string: "FFE1")], for: service)
            }
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for c in characteristics {
                service.peripheral?.setNotifyValue(true, for: c)
                peripheral.readValue(for: c)
                self.pairedCharacteristic = c
            }
            
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data = characteristic.value {
            let str = String(data: data, encoding: .utf8) ?? ""
            print(str)
            parseLogs(str)
        }
    }
    func parseLogs(_ str: String) {
        
        if let num = Int(String(str.filter {$0.isNumber})) {
            
        }
    }
    func sendCommand(_ command: DeviceCommand) {
        print(command.rawValue)
        if let commandData = command.rawValue.data(using: .utf8), let pairedCharacteristic = self.pairedCharacteristic {
            pairedDevice?.writeValue(commandData, for: pairedCharacteristic, type: .withoutResponse)
        } else {
            print("Invalid descriptor")
        }
    }
    
}
