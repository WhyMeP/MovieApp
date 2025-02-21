import Foundation

@MainActor
final class MovieDetailViewModel {
    
    protocol MovieDetailViewDelegate: BaseViewDelegate {
        func showMovieDetail(_ movieDetail: MovieDetailUIModel)
    }
    
    struct MovieDetailUIModel {
        let title: String
        let releaseDate: String
        let rating: NSAttributedString
        let overview: String
        let imageUrl: String
    }
    
    private weak var delegate: MovieDetailViewDelegate?
    private let movieRepository: MovieRepository
    private let movieId: Int
    
    init(delegate: MovieDetailViewDelegate?, movieId: Int, movieRepository: MovieRepository = DependencyContainer.movieRepository) {
        self.delegate = delegate
        self.movieId = movieId
        self.movieRepository = movieRepository
    }
    
    func onLoad() async {
        delegate?.showLoadingIndicator()
        do {
            let movieDetailResponse = try await movieRepository.getMovieDetail(for: movieId)
            delegate?.showMovieDetail(
                MovieDetailUIModel(
                    title: movieDetailResponse.title,
                    releaseDate: movieDetailResponse.releaseDate.formatMovieReleaseDate(),
                    rating: movieDetailResponse.rating.formatMovieRating(),
                    overview: movieDetailResponse.overview,
                    imageUrl: movieDetailResponse.posterUrl
                )
            )
        } catch {
            delegate?.showError { [weak self] in Task { await self?.onLoad() } }
        }
        
        delegate?.hideLoadingIndicator()
    }
    
}
