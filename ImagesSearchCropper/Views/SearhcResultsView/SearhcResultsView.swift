
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
                                        AsyncImage(url: image.largeImageURL) { phase in
                                            phase.image?
                                                .resizable()
                                                .scaledToFill()
                                                .cornerRadius(5)
                                        }
                                        
                                        if let url = image.largeImageURL {
                                            ShareLink(item: url) {
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .foregroundStyle(Color.userGray)
                                                        .frame(width: 32, height: 32)
                                                    
                                                    Image(systemName: "square.and.arrow.up")
                                                        .foregroundStyle(Color.darkPurple)
                                                }
                                            }
                                            .padding(20)
                                        }
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
