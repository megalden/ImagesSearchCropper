
import SwiftUI

@main
struct ImagesSearchCropperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel(network: PixabayNetworkClientData(networkClient: NetworkClient())))
        }
    }
}
