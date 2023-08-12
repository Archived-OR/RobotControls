import SwiftUI
import CoreBluetooth

struct RoverComponent: Identifiable, Hashable {
    var id = UUID().uuidString
    var name = "BLE Module"
    var status = StatusType.critical
    var characteristic: CBCharacteristic?
}
enum StatusType: String, Codable {
    case critical
    case subNominal
    case nominal
}
extension RoverComponent {
    static let all = [
        RoverComponent()
    ]
}
