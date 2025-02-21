@testable import MovieApp

enum MockMovieDetailResponseData {
    
    static func generate() -> MovieDetailResponse {
        MovieDetailResponse(
            title: "Moana 2",
            releaseDate: "2024-11-21",
            rating: 8.71,
            posterUrl: "/aLVkiINlIeCkcZIzb7XHzPYgO6L.jpg",
            overview: "Overview of the movie"
        )
    }
}
