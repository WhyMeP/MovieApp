import Foundation
import Observation

@MainActor
@Observable
final class LoginViewModel {
    
    enum State {
        case initial
        case loading
        case error
    }
    
    var state = State.initial
    var email: String = "phvallabh@gmail.com"
    var password: String = "12343"
    
    private let loginRepository: LoginRepository
    private let sensitiveStorageRepository: SensitiveStorageRepository
    private let loginCoordinator: LoginCoordinator
    
    init(
        loginRepository: LoginRepository = DependencyContainer.loginRepository,
        sensitiveStorageRepository: SensitiveStorageRepository = DependencyContainer.sensitiveStorageRepository,
        loginCoordinator: LoginCoordinator = DependencyContainer.loginCoordinator
    ) {
        self.loginRepository = loginRepository
        self.loginCoordinator = loginCoordinator
        self.sensitiveStorageRepository = sensitiveStorageRepository
    }
    
    var enableLoginButton: Bool {
        isEmailValid() && isPasswordValid() && state != .loading
    }
    
    func submitLoginCredentials() async {
        do {
            state = .loading
            let emailValue = email.trimmingCharacters(in: .whitespaces)
            let passwordValue = password.trimmingCharacters(in: .whitespaces)
            let response = try await loginRepository.login(request: .init(email: emailValue, password: passwordValue))
            try await sensitiveStorageRepository.storeAccessToken(response.accessToken)
            state = .initial
            loginCoordinator.onSuccessfullyLoggedIn()
        } catch {
            state = .error
        }
        
    }
    
    func onLogin() {
        state = .loading
    }
    
    func onRetry() {
        state = .loading
    }
    
    private func isEmailValid() -> Bool {
        let emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isPasswordValid() -> Bool {
        let passwordValue = password.trimmingCharacters(in: .whitespaces)
        return passwordValue.count >= 4
    }
}
