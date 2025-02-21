import Testing
@testable import MovieApp

@MainActor
class MovieListViewModelTests {
    
    private let mockRepository: MockMovieRepository
    private let mockMovieCoordinator: MockMovieCoordinator
    private let sut: MovieListViewModel
    
    init() {
        self.mockRepository = MockMovieRepository()
        self.mockMovieCoordinator = MockMovieCoordinator()
        self.sut = MovieListViewModel(movieRepository: mockRepository, movieCoordinator: mockMovieCoordinator)
    }
    
    deinit {
        mockRepository.verifyCount()
        mockMovieCoordinator.verifyCount()
    }
    
    @Test func testGivenGetMoviesIsSuccessfulWhenOnLoadIsCalledThenStateIsLoaded() async throws {
        await simulateSuccessGetMovies()
        
        #expect(sut.state == .loaded([createMockMovieUIModel(), createSecondMockMovieUIModel()]))
        
    }
    
    @Test func testGivenGetMoviesFailWhenOnLoadIsCalledThenStateIsError() async throws {
        mockRepository.getMoviesHandlerCallCount = 1
        mockRepository.getMoviesHandler = {
            throw MockError.genreateError()
        }
        
        await sut.onLoad()
        
        #expect(sut.state == .error)
    }
        
    @Test func givenSearchIsEmptyAndStateLoadedIsEmptyAndThereIsMoviesWhenOnSearchIsCalledThenStateIsLoadedWithMovies() async throws {
        await simulateSuccessGetMovies()
        sut.state = .loaded([])
        #expect(sut.state == .loaded([]))
        sut.search = ""
        
        sut.onSearch()
        
        #expect(sut.state == .loaded([createMockMovieUIModel(), createSecondMockMovieUIModel()]))
    }
    
    @Test func givenSearchIsWhiteSpacesAndStateLoadedIsEmptyAndThereIsMoviesWhenOnSearchIsCalledThenStateIsLoadedWithMovies() async throws {
        await simulateSuccessGetMovies()
        sut.state = .loaded([])
        #expect(sut.state == .loaded([]))
        sut.search = "            "
        
        sut.onSearch()
        
        #expect(sut.state == .loaded([createMockMovieUIModel(), createSecondMockMovieUIModel()]))
    }
    
    @Test func givenSearchIWithUppercaseWhenOnSearchIsCalledThenStateIsLoadedWithFilteredMovies() async throws {
        await simulateSuccessGetMovies()
        #expect(sut.state == .loaded([createMockMovieUIModel(), createSecondMockMovieUIModel()]))
        sut.search = "MOANA"
        
        sut.onSearch()
        
        #expect(sut.state == .loaded([createMockMovieUIModel()]))
    }
    
    @Test func givenSearchIWithLowercaesWhenOnSearchIsCalledThenStateIsLoadedWithFilteredMovies() async throws {
        await simulateSuccessGetMovies()
        #expect(sut.state == .loaded([createMockMovieUIModel(), createSecondMockMovieUIModel()]))
        sut.search = "moana"
        
        sut.onSearch()
        
        #expect(sut.state == .loaded([createMockMovieUIModel()]))
    }
    
    @Test func givenSearchIWithExtraWhiteSpaceCharactersWhenOnSearchIsCalledThenStateIsLoadedWithFilteredMovies() async throws {
        await simulateSuccessGetMovies()
        #expect(sut.state == .loaded([createMockMovieUIModel(), createSecondMockMovieUIModel()]))
        sut.search = "  moana  "
        
        sut.onSearch()
        
        #expect(sut.state == .loaded([createMockMovieUIModel()]))
    }
    
    @Test func givenSearchWhichDoesNotExistWhenOnSearchIsCalledThenStateIsLoadedWithNoMovies() async throws {
        await simulateSuccessGetMovies()
        #expect(sut.state == .loaded([createMockMovieUIModel(), createSecondMockMovieUIModel()]))
        sut.search = "Ben10"
        
        sut.onSearch()
        
        #expect(sut.state == .loaded([]))
    }
    

    @Test func testWhenOnRetryIsCalledThenStateIsLoading() async throws {
        sut.onRetry()
        #expect(sut.state == MovieListViewModel.State.loading)
    }

    @Test func testWhenOnItemClickedIsCallThenItNavigatesToMovieDetailScreen() async throws {
        mockMovieCoordinator.toDetailHandlerCallCount = 1
        mockMovieCoordinator.toDetailHandler = { id in
            #expect(id == 1)
        }
        
        sut.onItemClicked(movie: createMockMovieUIModel())
    }
    
    
    private func simulateSuccessGetMovies() async {
        mockRepository.getMoviesHandlerCallCount = 1
        mockRepository.getMoviesHandler = {
            return MockMovieListResponseData.generate()
        }
        
        await sut.onLoad()
    }
    
    private func createMockMovieUIModel() -> MovieListViewModel.State.MovieUIModel {
        return MovieListViewModel.State.MovieUIModel(
            id: 1,
            title: "Moana 2",
            releaseDate: "21 November 2024",
            imageUrl: "/aLVkiINlIeCkcZIzb7XHzPYgO6L.jpg",
            rating: 8.71
          )
    }
    
    private func createSecondMockMovieUIModel() -> MovieListViewModel.State.MovieUIModel {
        return MovieListViewModel.State.MovieUIModel(
            id: 2,
            title: "Kraven the Hunter",
            releaseDate: "21 December 2024",
            imageUrl: "/aLVkiINlIeCkcZIzb7XHzPYgO6L.jpg",
            rating: 8.74
          )
    }
}

extension MovieListViewModel.State: @retroactive Equatable {
    public static func == (lhs: MovieListViewModel.State, rhs: MovieListViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.loaded(let lhsMovies), .loaded(let rhsMovies)):
            return lhsMovies == rhsMovies
        case (.error, .error):
            return true
        default:
            return false
        }
    }
}

extension MovieListViewModel.State.MovieUIModel: @retroactive Equatable {
    public static func == (lhs: MovieListViewModel.State.MovieUIModel, rhs: MovieListViewModel.State.MovieUIModel) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.imageUrl == rhs.imageUrl &&
        lhs.rating == rhs.rating &&
        lhs.releaseDate == rhs.releaseDate
    }
}
