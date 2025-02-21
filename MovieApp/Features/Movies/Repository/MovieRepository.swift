protocol MovieRepository {
    func getMovies() async throws -> MovieListResponse
    func getMovieDetail(for id: Int) async throws -> MovieDetailResponse
}

final class MovieRepositoryImplementation: MovieRepository {
    
    private let networkingClient: NetworkingClient
    
    init(networkingClient: NetworkingClient = DependencyContainer.movieNetworkingClient) {
        self.networkingClient = networkingClient
    }
    
    func getMovies() async throws -> MovieListResponse {
        let response: MovieListResponse = try await networkingClient.getApi(path: "/movie/popular")
        return response
    }
    
    func getMovieDetail(for id: Int) async throws -> MovieDetailResponse {
        let response: MovieDetailResponse = try await networkingClient.getApi(path: "/movie/\(id)")
        return response
    }
}
