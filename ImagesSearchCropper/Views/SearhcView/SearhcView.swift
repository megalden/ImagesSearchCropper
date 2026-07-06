
import SwiftUI

struct SearhcView: View {
    @ObservedObject var appViewModel: AppViewModel
    @ObservedObject var searchViewModel: SearchViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("Have a visual adventure for your audience")
                .font(.system(size: 36,weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(15)
                    .foregroundStyle(.gray)
                
                TextField("Search images", text: $searchViewModel.searchText)
                    .font(.system(size: 20))
                    .textFieldStyle(PlainTextFieldStyle())
                
            }
            .frame(height: 70)
            .background(.white)
            .cornerRadius(5)
            
            Button {
                appViewModel.screen = .results
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(height: 70)
                        .foregroundStyle(Color.darkPurple)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .foregroundStyle(.white)
                    .font(.system(size: 24))
                }
            }
            
            Button {
                appViewModel.screen = .localImage
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(height: 70)
                        .foregroundStyle(Color.darkPurple)
                    
                    HStack {
                        Image(systemName: "folder")
                        Text("Gallery")
                    }
                    .foregroundStyle(.white)
                    .font(.system(size: 24))
                }
            }
            
            Spacer()
            
            Text("Photo by Free-Photos")
                .foregroundStyle(.white)
        }
        .padding(20)
        .background(
            Image(.photoWallpaper)
                .resizable()
                .scaledToFill()
            
                .overlay(
                    Color.black.opacity(0.4)
                )
        )
        .ignoresSafeArea()
    }
}

#Preview {
    SearhcView(
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
