
import SwiftUI

@main
struct ImagesSearchCropperApp: App {
    @StateObject private var appViewModel = AppViewModel()
    
    @StateObject private var searchViewModel = SearchViewModel(
        network: PixabayNetworkClientData(networkClient: NetworkClient())
    )
    
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
            }
        }
    }
}
