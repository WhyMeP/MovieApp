import SwiftUI

struct LoginView: View {
    
    enum FocusField: Hashable {
        case email
        case password
    }

    @State private var viewModel = LoginViewModel()
    @FocusState var focused: FocusField?
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            ZStack {
                loadedView
                    
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(Color.yellow)
                    .scaleEffect(3)
            }.task {
                await viewModel.submitLoginCredentials()
            }
        case .error:
            ErrorView {
                viewModel.onRetry()
            }
        case .initial:
            loadedView
        }
    }
    
    private var loadedView: some View {
        VStack(spacing: 8) {
            Text(String(localized: "Welcome message", table: "Login"))
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            TextField(String(localized: "Email placeholder", table: "Login"), text: $viewModel.email)
                .focused($focused, equals: .email)
                .onSubmit { focused = .password }
                .keyboardType(.emailAddress)
                .padding()
                .border(.secondary)
            SecureField(String(localized: "Password placeholder", table: "Login"), text: $viewModel.password)
                .focused($focused, equals: .password)
                .padding()
                .border(.secondary)
            Spacer()
                        
            Button(action: {
                viewModel.onLogin()
            }) {
                Text(String(localized: "Login button title", table: "Login"))
                    .padding(8)
                    .frame(maxWidth: .infinity)
            }
            .disabled(!viewModel.enableLoginButton)
            .buttonStyle(.borderedProminent)
         }
        .padding(16)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(String(localized: "Navigation title", table: "Login"))
    }
    
}
