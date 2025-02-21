import Testing
import XCTest
@testable import MovieApp

class MovieRepositoryTests {
    
    private let mockNetworkingClient: MockNetworkingClient
    private let sut: MovieRepositoryImplementation

    init() {
        mockNetworkingClient = MockNetworkingClient()
        sut = MovieRepositoryImplementation(networkingClient: mockNetworkingClient)
    }
    
    deinit {
        mockNetworkingClient.verifyCount()
    }
    
    @Test
    func testGivenGetApiIsSuccessfullWhenGetMoviesIsCalledThenReturnMovieListResponse() async throws {
        mockNetworkingClient.getApiHandler = { path in
            #expect(path == "/movie/popular")
            return MockMovieListResponseData.generate()
        }
        
        mockNetworkingClient.getApiHandlerCallCount = 1
        
        let response: MovieListResponse = try await sut.getMovies()
        
        #expect(response.results.count == 2)
        #expect(response == MockMovieListResponseData.generate())
    }
    
    
    @Test
    func testGivenGetApiFailWhenGetMoviesIsCalledThenThrowError() async throws {
        let error = MockError.genreateError()
        
        mockNetworkingClient.getApiHandler = { path in
            #expect(path == "/movie/popular")
            throw error
        }
        
        mockNetworkingClient.getApiHandlerCallCount = 1
        
        do{
            let _: MovieListResponse = try await sut.getMovies()
            XCTFail("Should not be successful")
        } catch {
            #expect(error != nil)
        }
    }
    
    @Test
    func testGivenGetApiIsSuccessfullWhenGetMovieDetailIsCalledThenReturnMovieMovieResponse() async throws {
        mockNetworkingClient.getApiHandler = { path in
            #expect(path == "/movie/1")
            return MockMovieDetailResponseData.generate()
        }
        
        mockNetworkingClient.getApiHandlerCallCount = 1
        
        let response: MovieDetailResponse = try await sut.getMovieDetail(for: 1)
        
        #expect(response ==  MockMovieDetailResponseData.generate())
    }
    
    @Test
    func testGivenGetApiFailWhenGetMovieDetailIsCalledThenThrowError() async throws {
        let error = MockError.genreateError()
        
        mockNetworkingClient.getApiHandler = { path in
            #expect(path == "/movie/1")
            throw error
        }
        
        mockNetworkingClient.getApiHandlerCallCount = 1
        
        do{
            let _: MovieDetailResponse = try await sut.getMovieDetail(for: 1)
            XCTFail("Should not be successful")
        } catch {
            #expect(error != nil)
        }
    }
    
}

extension MovieListResponse: @retroactive Equatable {
    public static func == (lhs: MovieListResponse, rhs: MovieListResponse) -> Bool {
        return lhs.results == rhs.results
    }
}

extension MovieListResponse.Result: @retroactive Equatable {
    public static func == (lhs: MovieListResponse.Result, rhs: MovieListResponse.Result) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.releaseDate == rhs.releaseDate &&
        lhs.posterUrl == rhs.posterUrl &&
        lhs.rating == rhs.rating
    }
}

extension MovieDetailResponse: @retroactive Equatable {
    public static func == (lhs: MovieDetailResponse, rhs: MovieDetailResponse) -> Bool {
        return lhs.overview == rhs.overview &&
        lhs.rating == rhs.rating &&
        lhs.title == rhs.title &&
        lhs.releaseDate == rhs.releaseDate &&
        lhs.posterUrl == rhs.posterUrl
    }
}
