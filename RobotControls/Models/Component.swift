import SwiftUI
import CoreBluetooth

struct Component: Identifiable, Hashable {
    var id = UUID().uuidString
    var name = "BLE Module"
    var status = StatusType.Critical
    var characteristic: CBCharacteristic?
}
enum StatusType: String, Codable {
    case Critical
    case SubNominal
    case Nominal
}
extension Component {
    static let all = [
        Component(name: "Stepper"),
    ]
}
