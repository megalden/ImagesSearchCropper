
import SwiftUI

@main
struct ImagesSearchCropperApp: App {
    @StateObject private var appViewModel = AppViewModel()
    
    @StateObject private var searchViewModel = SearchViewModel(
        repository: ImageRepository(
            networkClient: PixabayNetworkClientData(
                networkClient: NetworkClient()
            ),
            imageLoader: ImageLoader(),
            imageCaching: ImageCachingService()
        )
    )
    
    @StateObject private var localImageViewModel = LocalImageViewModel()
    
    var body: some Scene {
        WindowGroup {
            switch appViewModel.screen {
            case .search:
                SearhcView(
                    appViewModel: appViewModel,
                    searchViewModel: searchViewModel
                )
                
            case .results:
                SearhcResultsView(
                    appViewModel: appViewModel,
                    searchViewModel: searchViewModel
                )
                
            case .localImage:
                LocalImageListView(localImageViewModel: localImageViewModel, appViewModel: appViewModel)
                
            }
        }
    }
}
