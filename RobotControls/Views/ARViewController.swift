import SwiftUI
import ARKit
import RealityKit

struct ARViewController: UIViewRepresentable {
    var viewModel: ViewModel
    func makeUIView(context: Context) -> ARView {
       
        return viewModel.state.arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}
