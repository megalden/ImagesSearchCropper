
import SwiftUI
import PhotosUI

struct LocalImageListView: View {
    @ObservedObject var localImageViewModel: LocalImageViewModel
    @ObservedObject var appViewModel: AppViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            Group {
                if localImageViewModel.photos.isEmpty {
                    EmptyStateView(selectedItems: $localImageViewModel.selectedItems)
                } else {
                    ScrollView() {
                        LazyVGrid(columns: columns) {
                            ForEach($localImageViewModel.photos) { $photo in
                                LocalImageItemView(image: $photo.image)
                            }
                        }
                    }
                    .padding(10)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if !localImageViewModel.photos.isEmpty {
                        Button("Delete") {
                            localImageViewModel.clearPhotos()
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Back", systemImage: "chevron.left") {
                        appViewModel.screen = .search
                    }
                        
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(
                        selection: $localImageViewModel.selectedItems,
                        maxSelectionCount: 10,
                        matching: .images) {
                            Label("Add", systemImage: "plus")
                        }
                        .disabled(localImageViewModel.isLoading)
                }
            }
            .onChange(of: localImageViewModel.selectedItems) { _ in
                Task {
                    await localImageViewModel.loadSelectedPhotos()
                }
            }
        }
        
    }
}

#Preview {
    LocalImageListView(localImageViewModel: LocalImageViewModel(), appViewModel: AppViewModel())
}
