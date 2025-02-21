import SwiftUI
import UIKit

struct MovieRemoteImageView: View {
    
    enum Size: String {
        case small = "w300"
        case large = "w400"
    }
    
    let imagePath: String
    let size: Size
    let contentMode: ContentMode
    let appEnvironment: AppEnvironment
    
    init(
        imagePath: String,
        size: Size,
        contentMode: ContentMode = .fit,
        appEnvironment: AppEnvironment = DependencyContainer.appEnvironment) {
        self.imagePath = imagePath
        self.size = size
        self.contentMode = contentMode
        self.appEnvironment = appEnvironment
    }

    var body: some View {
        AsyncImage(url: URL(string: appEnvironment.movieImageBaseURL + "/\(size.rawValue)" + imagePath)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: contentMode)

        } placeholder: {
            Color.gray
        }
    }
}
