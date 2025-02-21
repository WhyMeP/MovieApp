import Foundation

struct MovieListResponse: Decodable {
    
    let results: [Result]
    
    struct Result: Decodable {
        
        let id: Int
        let title: String
        let releaseDate: String
        let posterUrl: String
        let rating: Double
        
        enum CodingKeys: String, CodingKey {
            case id
            case title
            case releaseDate = "release_date"
            case posterUrl = "poster_path"
            case rating = "vote_average"
        }
    }
}
