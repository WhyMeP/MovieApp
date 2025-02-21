import Foundation

protocol SensitiveStorageRepository {
    func storeAccessToken(_ value: String) async throws
}

final class SensitiveStorageRepositoryImplementation: SensitiveStorageRepository {
    
    private enum Constants {
        static let accessToken = "AccessToken"
    }
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func storeAccessToken(_ value: String) async throws {
        userDefaults.set(value, forKey: Constants.accessToken)
    }
}
