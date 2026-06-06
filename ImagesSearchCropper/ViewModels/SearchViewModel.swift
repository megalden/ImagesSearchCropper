
import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published private(set) var images: [ImageItem] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?
    
    let repository: ImageRepositoryProtocol
    
    init(repository: ImageRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchImages(query: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let images = try await repository.searchImages(query: query)
            
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
