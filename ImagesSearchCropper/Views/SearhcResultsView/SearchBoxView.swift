
import SwiftUI

struct SearchBoxView: View {
    @Binding var searchText: String
    @Binding var backSearch: AppViewModel.Screen
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                
                Button {
                    backSearch = .search
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 52, height: 52)
                            .foregroundStyle(Color.darkPurple)
                        
                        Text("P")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(10)
                        .foregroundStyle(.gray)
                    
                    TextField("Search images", text: $searchText)
                        .font(.system(size: 20))
                        .textFieldStyle(PlainTextFieldStyle())
                    
                }
                .frame(height: 52)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.userGray, lineWidth: 2)
                )
                .background(.gray.opacity(0.15))
                .cornerRadius(5)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color.userGray, style: StrokeStyle(lineWidth: 2))
                        .frame(width: 52, height: 52)
                        .foregroundStyle(.white)
                    
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal)
            
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    SearchBoxView(searchText: .constant(""), backSearch: .constant(.search))
}
