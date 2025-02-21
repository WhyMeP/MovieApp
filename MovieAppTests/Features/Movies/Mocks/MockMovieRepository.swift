import Foundation
import Testing
@testable import MovieApp

final class MockMovieRepository: MovieRepository {
    
    var getMoviesHandler: (() throws -> MovieListResponse)? = nil
    var getMoviesHandlerCallCount = 0
    
    var getMovieDetailHandler: ((Int) throws -> MovieDetailResponse)? = nil
    var getMovieDetailHandlerCallCount = 0
    
    func getMovies() async throws -> MovieApp.MovieListResponse {
        getMoviesHandlerCallCount -= 1
        return try getMoviesHandler!()
    }
    
    func getMovieDetail(for id: Int) async throws -> MovieDetailResponse {
        getMovieDetailHandlerCallCount -= 1
        return try getMovieDetailHandler!(id)
    }
    
    func verifyCount() {
        #expect(getMoviesHandlerCallCount == 0)
        #expect(getMovieDetailHandlerCallCount == 0)
    }
}
