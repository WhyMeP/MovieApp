import Foundation

enum MockError {
    
    static func genreateError() -> Error {
        return NSError(domain: "MockError", code: 0, userInfo: nil)
    }
}
