
import Foundation
import Combine

@MainActor
final class ViewModel: ObservableObject {
    @Published private(set) var images: [PixabayModel.Hit] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?
    
    let network: PixabayNetworkClientDataProtocol
    
    init(network: PixabayNetworkClientDataProtocol) {
        self.network = network
    }
    
    func fetchImages(query: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let images = try await network.fetchPhoto(q: query)
            await MainActor.run {
                self.images = images
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
