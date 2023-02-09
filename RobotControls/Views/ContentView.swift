import SwiftUI

struct ContentView: View {
    @StateObject var ble = BluetoothViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                ARViewController()
                    .ignoresSafeArea()
                OverlayView()
            }
            .navigationBarHidden(true)
        }
        .environmentObject(ble)
        
    }
}
