
import SwiftUI

struct SearhcResultsView: View {
    @ObservedObject var appViewModel: AppViewModel
    @ObservedObject var searchViewModel: SearchViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            SearchBoxView(searchText: $searchViewModel.searchText)
            
            Spacer()
            
            VStack {
                if searchViewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        VStack(alignment: .leading)  {
                            Text("\(searchViewModel.searchInfo?.total ?? 0 ) Free Images")
                                .padding(.horizontal)
                                .font(.system(size: 22, weight: .bold))
                            
                            VStack(spacing: 10) {
                                ForEach(searchViewModel.images, id: \.self) { image in
                                    ZStack(alignment: .topTrailing) {
                                        ImageBoxView(image: image)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .task(id: searchViewModel.searchText) {
            await searchViewModel.fetchImages(query: searchViewModel.searchText)
        }
    }
}

#Preview {
    SearhcResultsView( appViewModel: AppViewModel(), searchViewModel: SearchViewModel(network: PixabayNetworkClientData(networkClient: NetworkClient())))
}
