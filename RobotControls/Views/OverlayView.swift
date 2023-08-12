import SwiftUI

struct OverlayView: View {
    var viewModel: ViewModel
    var body: some View {
        VStack {
            Spacer()
            HStack {
                JoyStickView(viewModel: viewModel)
                Spacer()
                InfoView(viewModel: viewModel)
            } 
            .padding(.all)
        }
    }
}
