enum DependencyContainer {
    
    //MARK: Core
    
    static let appEnvironment: AppEnvironment = AppEnvironmentImplementation()
    
    static let navigationController: NavigationController = NavigationControllerImplementation()

    //MARK: Networking clients
    
    static let movieNetworkingClient: NetworkingClient = {
        let networkingClient = NetworkingClientImplentation(baseURL: appEnvironment.movieBaseURL, headers: [
            "Authorization": "Bearer \(appEnvironment.movieApiKey)"
        ])
        return networkingClient
    }()
    
    static let authenticationNetworkingClient: NetworkingClient = {
        let networkingClient = NetworkingClientImplentation(baseURL: appEnvironment.loginBaseURL)
        return networkingClient
    }()
    
    //MARK: Repository
    
    static var movieRepository: MovieRepository {
        MovieRepositoryImplementation()
    }
    
    static var loginRepository: LoginRepository {
        LoginRepositoryImplementation()
    }
    
    static let sensitiveStorageRepository: SensitiveStorageRepository = SensitiveStorageRepositoryImplementation()
    
    //MARK: Coordinator
    
    static let movieCoordinator: MovieCoordinator = MovieCoordinatorImplementation()
    
    static let loginCoordinator: LoginCoordinator = LoginCoordinatorImplementation()
    
}
