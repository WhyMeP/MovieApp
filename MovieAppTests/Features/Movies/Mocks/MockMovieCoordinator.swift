import UIKit
import Testing
@testable import MovieApp

final class MockMovieCoordinator: MovieCoordinator {
    var initalRootViewControllerHandler: (() -> Void)? = nil
    var initalRootViewControllerHandlerCallCount = 0
    
    var startJourneyHandler: (() -> Void)? = nil
    var startJourneyHandlerCallCount = 0
    
    var toDetailHandler: ((Int) -> Void)? = nil
    var toDetailHandlerCallCount = 0
    
    func initalRootViewController() {
        initalRootViewControllerHandlerCallCount -= 1
        initalRootViewControllerHandler!()
    }
    
    func startJourney() {
        startJourneyHandlerCallCount -= 1
        startJourneyHandler!()
    }
    
    func toDetail(movieId: Int) {
        toDetailHandlerCallCount -= 1
        toDetailHandler!(movieId)
    }
    
    func verifyCount() {
        #expect(initalRootViewControllerHandlerCallCount == 0)
        #expect(startJourneyHandlerCallCount == 0)
        #expect(toDetailHandlerCallCount == 0)
    }
}
