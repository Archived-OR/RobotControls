import SwiftUI
import ARKit
import RealityKit

struct ARViewController: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}
