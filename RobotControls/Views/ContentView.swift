import SwiftUI

struct ContentView: View {
    
    var viewModel: ViewModel = ViewModel(state: .startingState, network: .shared)

    var body: some View {
        NavigationStack {
            ZStack {
                ARViewController(viewModel: viewModel)
                    .ignoresSafeArea()
                OverlayView(viewModel: viewModel)
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.initializeSimulation()
            }
        }
    }
}
