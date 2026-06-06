
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
        images = []
        isLoading = true
        errorMessage = nil
        
        do {
            
            for try await imageItem in repository.searchImages(query: query) {
                guard !images.contains(where: { $0.id == imageItem.id }) else {
                        continue
                    }
                await MainActor.run {
                    images.append(imageItem)
                }
            }
            
            self.isLoading = false
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
