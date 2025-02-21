import Foundation
import Testing
@testable import MovieApp

final class MockNetworkingClient: NetworkingClient {
    
    var getApiHandler: ((String) throws -> Decodable)? = nil
    var getApiHandlerCallCount = 0
    
    var postApiHandler: ((String, Encodable) throws -> Decodable)? = nil
    var postApiHandlerCallCount = 0
    
    func getApi<Response>(path: String) async throws -> Response where Response : Decodable {
        getApiHandlerCallCount -= 1
        return try getApiHandler!(path) as! Response
    }
    
    func post<Request, Response>(to path: String, with body: Request) async throws -> Response where Request : Encodable, Response : Decodable {
        postApiHandlerCallCount -= 1
        return try postApiHandler!(path, body) as! Response
    }    
    
    func verifyCount() {
        #expect(getApiHandlerCallCount == 0)
        #expect(postApiHandlerCallCount == 0)
    }
}
