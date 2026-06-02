
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(viewModel.images, id: \.self) { image in
                    AsyncImage(url: image.previewURL) { phase in
                        phase.image?
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .task {
                await viewModel.fetchImages(query: "Fish")
            }
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel(network: PixabayNetworkClientData(networkClient: NetworkClient())))
}
