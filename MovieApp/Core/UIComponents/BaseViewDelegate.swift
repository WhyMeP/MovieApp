import UIKit
import SwiftUI

protocol BaseViewDelegate: AnyObject {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showError(onRetry: @escaping () -> Void)
}

private enum Constants {
    static let loadingViewTag: Int = 100
    static let errorViewTag: Int = 101
}

extension BaseViewDelegate where Self: UIViewController {
  
    func showError(onRetry: @escaping () -> Void) {
        let errorView = ErrorView(onRetry: { [weak self] in
            self?.view.viewWithTag(Constants.errorViewTag)?.removeFromSuperview()
            onRetry()
        })
        view.replaceAndAdd(view: errorView, tag: Constants.errorViewTag)
    }
        
    func showLoadingIndicator() {
        let loadingView = LoadingView()
        view.replaceAndAdd(view: loadingView, tag: Constants.loadingViewTag)
    }

    func hideLoadingIndicator() {
        self.view.viewWithTag(Constants.loadingViewTag)?.removeFromSuperview()
    }
}
