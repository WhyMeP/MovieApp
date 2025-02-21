import UIKit
import SwiftUI

protocol MovieCoordinator {
    func initalRootViewController()
    func startJourney()
    func toDetail(movieId: Int)
}

final class MovieCoordinatorImplementation: MovieCoordinator {
    
    private let navigationController: NavigationController
    
    init(navigationController: NavigationController = DependencyContainer.navigationController) {
        self.navigationController = navigationController
    }
    
    func initalRootViewController() {
        navigationController.setRootViewController(UIHostingController(rootView: MoviesListView()))
    }
    
    func startJourney() {
        let viewController = UIHostingController(rootView: MoviesListView())
        navigationController.pushViewController(viewController)
    }
        
    func toDetail(movieId: Int) {
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        if let initialViewController = storyboard.instantiateInitialViewController() as? MovieDetailViewController {
            initialViewController.id = movieId
            navigationController.pushViewController(initialViewController)
        }
    }
}
