import Foundation

protocol AppEnvironment {
    var movieApiKey: String { get }
    var movieBaseURL: String { get }
    var movieImageBaseURL: String { get }
    var loginEnabled: Bool { get }
    var loginBaseURL: String { get }
}

struct AppEnvironmentImplementation: AppEnvironment {
    let loginEnabled: Bool
    let loginBaseURL: String
    let movieApiKey: String
    let movieBaseURL: String
    let movieImageBaseURL: String
    
    init() {
        movieApiKey = Self.getvalue(forKey: .movieApiKey)
        movieBaseURL = Self.getvalue(forKey: .movieApiBaseURL)
        movieImageBaseURL = Self.getvalue(forKey: .movieImageBaseURL)
        loginEnabled = Self.getvalue(forKey: .loginEnabled) == "YES" ? true : false
        loginBaseURL = Self.getvalue(forKey: .loginBaseURL)
    }
}

private extension AppEnvironmentImplementation {
    
    private enum Key: String {
        case movieApiKey = "MOVIE_API_KEY"
        case movieApiBaseURL = "MOVIE_API_BASE_URL"
        case movieImageBaseURL = "MOVIE_IMAGE_BASE_URL"
        case loginBaseURL = "LOGIN_BASE_URL"
        case loginEnabled = "ENABLE_LOGIN"
    }
    
    private static func getvalue(forKey key: Key) -> String {
        
        guard let value = Bundle.main.infoDictionary?[key.rawValue] as? String else {
            fatalError("Missing \(key.rawValue) in the AppConfig")
        }

        return value
    }
}
