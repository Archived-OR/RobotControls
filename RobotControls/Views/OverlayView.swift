import SwiftUI

struct OverlayView: View {
    @EnvironmentObject var ble: BluetoothViewModel
    var body: some View {
        VStack {
            Spacer()
            HStack {
                JoyStickView()
                Spacer()
                InfoView()
            } 
            .padding(.all)
        }
    }
}
