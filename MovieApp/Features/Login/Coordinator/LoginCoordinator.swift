import UIKit
import SwiftUI

protocol LoginCoordinator {
    func initalRootViewController()
    func onSuccessfullyLoggedIn()
}

final class LoginCoordinatorImplementation: LoginCoordinator {
 
    private let navigationController: NavigationController
    private let movieCoordinator: MovieCoordinator
    
    init(
        navigationController: NavigationController = DependencyContainer.navigationController,
        movieCoordinator: MovieCoordinator = DependencyContainer.movieCoordinator
    ) {
        self.navigationController = navigationController
        self.movieCoordinator = movieCoordinator
    }
    
    func initalRootViewController() {
        navigationController.setRootViewController(UIHostingController(rootView: LoginView()))
    }
    
    func onSuccessfullyLoggedIn() {
        movieCoordinator.startJourney()
    }
}
