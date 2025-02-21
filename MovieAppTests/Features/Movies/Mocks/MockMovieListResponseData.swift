@testable import MovieApp

enum MockMovieListResponseData {
    
    static func generate() -> MovieListResponse {
        
        let result = MovieListResponse.Result(
            id: 1,
            title: "Moana 2",
            releaseDate: "2024-11-21",
            posterUrl: "/aLVkiINlIeCkcZIzb7XHzPYgO6L.jpg",
            rating: 8.71
        )
        
        let result2 = MovieListResponse.Result(
            id: 2,
            title: "Kraven the Hunter",
            releaseDate: "2024-12-21",
            posterUrl: "/aLVkiINlIeCkcZIzb7XHzPYgO6L.jpg",
            rating: 8.74
        )
        
        return MovieListResponse(
            results: [
                result,
                result2
            ]
        )
    }
}
