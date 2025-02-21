import SwiftUI

struct RatingIcon: View {

    @ScaledMetric(relativeTo: .caption) var size = 45
    
    let rating: Double
    
    private var displayRating: String {
        Decimal(rating).formatted(.number.precision(.fractionLength(1)))
    }

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: rating/10)
                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .foregroundStyle(Color(uiColor: .primary))
                .rotationEffect(Angle(degrees: 270.0))
                
            Text(displayRating)
                .foregroundStyle(Color.primaryText)
                .font(.caption2)
        }
        .frame(width: size)
    }
}


struct RatingIcon_Preview: PreviewProvider {
    static var previews: some View {
        RatingIcon(rating: 8.94)
    }
}

