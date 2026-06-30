
import Foundation
import Combine
import PhotosUI
import SwiftUI

@MainActor
final class LocalImageViewModel: ObservableObject {
    @Published private(set) var photos: [GalleryImage] = []
    @Published var selectedItems: [PhotosPickerItem] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    
    func loadSelectedPhotos() async {
        guard !selectedItems.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        var loadedPhotos: [GalleryImage] = []
        
        for item in selectedItems {
            do {
                if let data = try await item.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    loadedPhotos.append(GalleryImage(image: image))
                }
            } catch {
                errorMessage = error.localizedDescription
            }
        }
        
        photos.insert(contentsOf: loadedPhotos, at: 0)
        selectedItems.removeAll()
        isLoading = false
    }
    
    func clearPhotos() {
        photos.removeAll()
    }
}
