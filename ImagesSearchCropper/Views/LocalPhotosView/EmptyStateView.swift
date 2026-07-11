
import SwiftUI
import PhotosUI

struct EmptyStateView: View {
    @Binding var selectedItems: [PhotosPickerItem]
    
    var body: some View {
        
        PhotosPicker(
            selection: $selectedItems,
            maxSelectionCount: 10,
            matching: .images
        ) {
            Label("Add photos", systemImage: "photo")
        }
    }
}

