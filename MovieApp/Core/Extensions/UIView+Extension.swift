import SwiftUI

extension UIView {
    
    func replaceAndAdd<SwiftUIView: View>(view: SwiftUIView, tag: Int) {
        viewWithTag(tag)?.removeFromSuperview()
        let hostingController = UIHostingController(rootView: view)
        addSubview(hostingController.view)
        hostingController.view.frame = bounds
        hostingController.view.tag = tag
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingController.view.layer.masksToBounds = true
    }
}
