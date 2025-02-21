import Foundation

struct MovieDetailResponse: Decodable {
    
    let title: String 
    let releaseDate: String
    let rating: Double
    let posterUrl: String
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case posterUrl = "poster_path"
        case rating = "vote_average"
        case overview
    }
}
