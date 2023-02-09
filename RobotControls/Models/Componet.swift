import SwiftUI
import CoreBluetooth

struct Componet: Identifiable, Hashable {
    var id = UUID().uuidString
    var name = "BLE Module"
    var status = StatusType.Critical
    var chacteristic: CBCharacteristic?
}
enum StatusType: String, Codable {
    case Critical
    case SubNominal
    case Nominal
}
extension Componet {
    static let all = [
        Componet(name: "Stepper"),
    ]
}
