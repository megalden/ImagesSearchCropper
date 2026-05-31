
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    
    
    var body: some View {
        VStack {
            ForEach(viewModel.images, id: \.self) { image in
                Text("\(String(image.id ?? 0))")
                    .font(.system(size: 14))
            }
        }
        .padding()
        .task {
            await viewModel.fetchImages(query: "Fish")
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel(network: PixabayNetworkClientData(networkClient: NetworkClient())))
}
