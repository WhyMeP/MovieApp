import Foundation

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter
}()

extension String {
    
    func formatMovieReleaseDate() -> String {
        dateFormatter.date(from: self)?.formatted(date: .long, time: .omitted) ?? self
    }
}
