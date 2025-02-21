import SwiftUI

struct ErrorView: View {
    
    let onRetry: () -> Void
    
    var body: some View {
        
        VStack {
            Text("Something went wrong")
                .font(.headline)
                .foregroundStyle(.primaryText)
            Text("Tap to retry")
                .foregroundColor(.secondary)
        }
        .padding()
        .onTapGesture {
            self.onRetry()
        }
    }
}

struct ErrorView_Preview: PreviewProvider {
    static var previews: some View {
        ErrorView(onRetry: {})
            .padding()
    }
}
