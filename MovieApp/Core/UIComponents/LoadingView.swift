import SwiftUI

struct LoadingView: View {
    
    @State private var rotate = false
    
    @State private var scale = false
    
    var body: some View {
        ZStack {
            
            Circle()
                .foregroundStyle(Color.clear)
                .padding()
                .overlay(alignment: .top) {
                    Image(systemName: "movieclapper")
                        .font(.system(size: 45))
                        .padding()
                }
                .overlay(alignment: .bottom) {
                    Image(systemName: "video.fill")
                        .font(.system(size: 45))
                        .padding()
                }
                .rotationEffect(rotate ? .degrees(0) : .degrees(360))
                .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: rotate)
            
            Text("Loading ...")
                .font(.system(size: 20))
                .foregroundStyle(Color.primaryText)
            .scaleEffect(scale ? 2 : 1)
            .animation(.bouncy.repeatForever(autoreverses: true), value: scale)
            
        }.onAppear {
            rotate.toggle()
            scale.toggle()
        }
    }
}

struct LoadingView_Preview: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .padding()
    }
}
