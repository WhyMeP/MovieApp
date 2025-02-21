import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = DependencyContainer.navigationController
        let movieCoordinator = DependencyContainer.movieCoordinator
        let loginCoorinator = DependencyContainer.loginCoordinator
        let appEnvironment = DependencyContainer.appEnvironment
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController.initalController
        
        if(appEnvironment.loginEnabled) {
            loginCoorinator.initalRootViewController()
        } else {
            movieCoordinator.initalRootViewController()
        }
               
        self.window = window
        
        window.makeKeyAndVisible()
    }
}

