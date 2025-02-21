import SwiftUI

struct MoviesListView: View {
    
    @State private var viewModel = MovieListViewModel()
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                LoadingView()
                    .task {
                        await viewModel.onLoad()
                    }
            case .loaded(let movies):
                List(movies) { movie in
                    HStack {
                        MovieRemoteImageView(imagePath: movie.imageUrl, size: .small, contentMode: .fill)
                        .frame(width: 50, height: 50)
                            
                        VStack(alignment: .leading, spacing: 8) {
                            Text(movie.title)
                                .fontWeight(.bold)
                                .font(.headline)
                                .foregroundStyle(Color.primaryText)
                            Text("\(movie.releaseDate)")
                                .font(.callout)
                                .foregroundStyle(Color.primaryText)
                            RatingIcon(rating: movie.rating)
                        }.padding(.leading, 8)
                        
                        Spacer()
                        Image(systemName: "chevron.right")
                        
                    }.onTapGesture {
                        viewModel.onItemClicked(movie: movie)
                    }
                }
                .listStyle(.grouped)
                .searchable(text: $viewModel.search)
                .onChange(of: viewModel.search) {
                    viewModel.onSearch()
                }
                .overlay {
                    if movies.isEmpty {
                        ContentUnavailableView.search
                    }
                }
            case .error:
                ErrorView {
                    viewModel.onRetry()
                }
            }
        }
        .navigationTitle("Popular Movie List")
        .navigationBarBackButtonHidden()
    }
}
