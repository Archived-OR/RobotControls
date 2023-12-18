import SwiftUI

struct InfoView: View {
    @EnvironmentObject var ble: BluetoothViewModel
    @State private var stepperActive = false
    var body: some View {
        VStack(alignment: .trailing) {
            
            Label((ble.pairedDevice == nil ? "NOT " : "") + "CONNECTED", systemImage: ble.pairedDevice == nil ? "antenna.radiowaves.left.and.right.slash" : "antenna.radiowaves.left.and.right")
                .font(.headline)
                .foregroundStyle(.primary, ble.pairedDevice == nil ? .red : .green)
                .padding()
                .background(in: Capsule(), fillStyle: FillStyle())        
            Label("100%", systemImage: "battery.100")
                .font(.headline)
                .foregroundStyle(.green, .white)
                .padding(.all)
                .background(in: Capsule(), fillStyle: FillStyle())
            ForEach(ble.components) { component in
                let isStepper = component.name.lowercased().contains("stepper")
                Label(component.name, systemImage: isStepper ? (stepperActive ? "checkmark.circle.fill" : "xmark.octagon.fill") : component.status == .Critical ? "xmark.octagon.fill" : "checkmark.circle.fill")
                    .foregroundStyle(isStepper ? (stepperActive ? .green : .red) : component.status == .Critical ? Color.red : Color.green)
                    .padding(.all)
                    .background(in: Capsule(), fillStyle: FillStyle())
                    .onTapGesture {
                        if isStepper {
                            if stepperActive {
                                ble.sendCommand(.stopRotate)
                            } else {
                                ble.sendCommand(.rotate)
                            }
                            stepperActive.toggle()
                        }
                    }
            }
        }
        
    }
}
