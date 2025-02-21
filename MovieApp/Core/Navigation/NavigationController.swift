import UIKit

protocol NavigationController {
    var initalController: UIViewController { get }
    func setRootViewController(_ viewController: UIViewController)
    func pushViewController(_ viewController: UIViewController)
}

final class NavigationControllerImplementation: NavigationController {
    
    private let navigationController = UINavigationController()
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.primary

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.primaryText,
        ]

        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.primaryText,
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var initalController: UIViewController {
        navigationController
    }

    func setRootViewController(_ viewController: UIViewController) {
        navigationController.viewControllers = [viewController]
    }
    
    func pushViewController(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
