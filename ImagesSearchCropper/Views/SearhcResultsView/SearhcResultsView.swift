
import SwiftUI

struct SearhcResultsView: View {
    @ObservedObject var appViewModel: AppViewModel
    @ObservedObject var searchViewModel: SearchViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            SearchBoxView(searchText: $searchViewModel.searchText)
                .background(Color.white)
            
            Spacer()
            
            VStack(alignment: .leading) {
                if searchViewModel.isLoading {
                    Spacer()
                    
                    VStack() {
                        ProgressView()
                        Text("Loading...")
                    }
                    
                    Spacer()
                } else {
                    NavigationStack {
                        ScrollView {
                            VStack(alignment: .leading)  {
                                Text("Free Images")
                                    .padding(.horizontal)
                                    .font(.system(size: 22, weight: .bold))
                                
                                VStack(spacing: 10) {
                                    ForEach(searchViewModel.images, id: \.self) { image in
                                        NavigationLink(destination: ImagePageView(image: image.image)) {
                                            ImageBoxView(image: image.image)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                                .padding(.horizontal)
                            }
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
    SearhcResultsView(
        appViewModel: AppViewModel(),
        searchViewModel: SearchViewModel(
            repository: ImageRepository(
                networkClient: PixabayNetworkClientData(
                    networkClient: NetworkClient()
                ),
                imageLoader: ImageLoader(),
                imageCaching: ImageCaching()
            )
        )
    )
}
