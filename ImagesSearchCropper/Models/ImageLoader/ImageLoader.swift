import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false
    @Published var error: Error?
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func load(from url: URL?) async {
        guard let url else { return }
        
        image = nil
        isLoading = true
        error = nil
        
        do {
            let (data, _) = try await session.data(from: url)
            
            guard let image = UIImage(data: data) else {
                return
            }
            
            await MainActor.run {
                self.image = image
            }
        } catch {
            await MainActor.run {
                self.error = error
            }
        }
    }
}
