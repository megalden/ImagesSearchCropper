
import SwiftUI

struct SearchBoxView: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 52, height: 52)
                        .foregroundStyle(Color.darkPurple)
                    
                    Text("P")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.white)
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
                        .stroke(.gray.opacity(0.3), lineWidth: 2)
                )
                .background(.gray.opacity(0.15))
                .cornerRadius(5)
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(.gray.opacity(0.3), style: StrokeStyle(lineWidth: 2))
                        .frame(width: 52, height: 52)
                        .foregroundStyle(.white)
                    
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal, 20)
            
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(.gray.opacity(0.4))
        }
    }
}

#Preview {
    SearchBoxView(searchText: .constant("Bob"))
}
