import Foundation

protocol LoginRepository {
    func login(request: LoginRequest) async throws -> LoginResponse
}

final class LoginRepositoryImplementation: LoginRepository {
    
    private let networkingClient: NetworkingClient
    
    init(networkingClient: NetworkingClient = DependencyContainer.authenticationNetworkingClient) {
        self.networkingClient = networkingClient
    }
    
    func login(request: LoginRequest) async throws -> LoginResponse {
        try await networkingClient.post(to: "/login", with: request)
    }
}
