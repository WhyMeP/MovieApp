import Foundation

protocol NetworkingClient {
    func getApi<Response: Decodable>(path: String) async throws -> Response
    func post<Request: Encodable, Response: Decodable>(to path: String, with body: Request) async throws -> Response
}

final class NetworkingClientImplentation: NetworkingClient {
    private let baseURL: String
    private let headers: [String: String]
    private let session: URLSession
    
    init(baseURL: String,
        headers: [String: String] = [:],
        session: URLSession = .shared) {
        
        self.baseURL = baseURL
        self.headers = headers
        self.session = session
    }
    
    func getApi<Response: Decodable>(path: String) async throws -> Response {
        return try await performRestRequest(constructUrlRequest(for: path, restMethod: .get))
    }
    
    func post<Request: Encodable, Response: Decodable>(to path: String, with body: Request) async throws -> Response  {
        return try await performRestRequest(constructUrlRequest(for: path, restMethod: .post, requestBody: body))
    }
}

private extension NetworkingClientImplentation {
    
    private enum RestMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    private func constructUrlRequest(
        for path: String,
        restMethod: RestMethod,
        requestBody: Encodable? = nil
    ) throws -> URLRequest {
        guard let baseURL = URL(string: baseURL) else {
            fatalError("Terminating due to failure to construct base URL.")
        }
        let fullURL = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = restMethod.rawValue
        if let requestBody {
            urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        }

        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        return urlRequest
    }
    
    func performRestRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
