import SwiftUI

struct JoyStickView: View {
    @State var offset = CGSize()
    @EnvironmentObject var ble: BluetoothViewModel

    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.thickMaterial)
                .frame(maxWidth: 150)
            Circle()
                .foregroundStyle(.thinMaterial)
                .frame(maxWidth: 100)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.linear) {
                                offset = value.translation
                                if value.translation.width < 150 {
                                    ble.sendCommand(.left)
                                } else {
                                    ble.sendCommand(.right)
                                }
                                
                                if value.translation.height < 150 {
                                    ble.sendCommand(.forward)
                                } else {
                                    ble.sendCommand(.back)
                                }
                            }    
                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        })
                )
        }
        .padding(.all)
        .aspectRatio(1/1, contentMode: .fit)
        .onAppear {
            ble.start()
        }
    }
}
