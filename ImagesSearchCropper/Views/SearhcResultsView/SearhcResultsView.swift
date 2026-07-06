
import SwiftUI

struct SearhcResultsView: View {
    @ObservedObject var appViewModel: AppViewModel
    @ObservedObject var searchViewModel: SearchViewModel
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
        
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                SearchBoxView(searchText: $searchViewModel.searchText, backSearch: $appViewModel.screen)
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
                        
                        ScrollView {
                            VStack(alignment: .leading)  {
                                Text("Free Images")
                                    .padding(.horizontal)
                                    .font(.system(size: 22, weight: .bold))
                                
                                LazyVGrid(columns: columns, spacing: 10) {
                                    ForEach(searchViewModel.images, id: \.self) { image in
                                        NavigationLink(destination: ImagePageView(
                                            appViewModel: appViewModel, image: image,
                                            searchText: $searchViewModel.searchText)) {
                                                ImageBoxView(image: image)
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
