
import SwiftUI
import PhotosUI

struct LocalImageListView: View {
    @StateObject var viewModel = LocalImageViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.photos.isEmpty {
                    EmptyStateView(selectedItems: $viewModel.selectedItems)
                } else {
                    ScrollView() {
                        VStack {
                            ForEach(viewModel.photos) { photo in
                                Image(uiImage: photo.image)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if !viewModel.photos.isEmpty {
                        Button("Delete") {
                            viewModel.clearPhotos()
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(
                        selection: $viewModel.selectedItems,
                        maxSelectionCount: 10,
                        matching: .images) {
                            Label("Add", systemImage: "plus")
                        }
                        .disabled(viewModel.isLoading)
                }
            }
            .onChange(of: viewModel.selectedItems) { _ in
                Task {
                    await viewModel.loadSelectedPhotos()
                }
            }
        }
        
    }
}

#Preview {
    LocalImageListView()
}
