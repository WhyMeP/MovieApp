import Observation

@MainActor
@Observable
final class MovieListViewModel {
    
    enum State {
        case loading
        case error
        case loaded([MovieUIModel])
        
        struct MovieUIModel: Identifiable {
            let id: Int
            let title: String
            let releaseDate: String
            let imageUrl: String
            let rating: Double
        }
    }
    
    var state = State.loading
    var search: String = ""
    
    private let movieRepository: MovieRepository
    private let movieCoordinator: MovieCoordinator
    private var orignalListOfMovies: [State.MovieUIModel] = []
    
    init(
        movieRepository: MovieRepository = DependencyContainer.movieRepository,
        movieCoordinator: MovieCoordinator = DependencyContainer.movieCoordinator
    ) {
        self.movieRepository = movieRepository
        self.movieCoordinator = movieCoordinator
    }
    
    func onLoad() async {
        do {
            let moviesListResponse = try await movieRepository.getMovies()
            orignalListOfMovies = moviesListResponse.results.map { movie in
                State.MovieUIModel(
                    id: movie.id,
                    title: movie.title,
                    releaseDate: movie.releaseDate.formatMovieReleaseDate(),
                    imageUrl: movie.posterUrl,
                    rating: movie.rating
                )
            }
            state = .loaded(orignalListOfMovies)
        } catch {
            state = .error
        }
    }
    
    func onSearch() {
        let serachValue = search.trimmingCharacters(in: .whitespaces)
        if(serachValue.isEmpty) {
            state = .loaded(orignalListOfMovies)
        } else {
            state = .loaded(orignalListOfMovies.filter { $0.title.lowercased().contains(serachValue.lowercased())})
        }
    }
    
    func onRetry() {
        state = .loading
    }
    
    func onItemClicked(movie: State.MovieUIModel) {
        movieCoordinator.toDetail(movieId: movie.id)
    }
}
