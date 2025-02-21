import Foundation
import UIKit

extension Double {
    
    func formatMovieRating() -> NSAttributedString {
        let formattedValue = String(format: "%.1f", self)
        let attributedString = NSMutableAttributedString()

        let normalFont = UIFont.preferredFont(forTextStyle: .subheadline)
        let normalAttributes: [NSAttributedString.Key: Any] = [.font: normalFont]
        let normalText = NSAttributedString(string: formattedValue, attributes: normalAttributes)
        attributedString.append(normalText)

        let smallerFont = UIFont.preferredFont(forTextStyle: .caption2)
        let smallerAttributes: [NSAttributedString.Key: Any] = [.font: smallerFont]
        let smallerText = NSAttributedString(string: " /10", attributes: smallerAttributes)
        attributedString.append(smallerText)
        
        return attributedString
    }
    
}
