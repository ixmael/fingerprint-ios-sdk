import Foundation
public struct FingerprintService: FingerprintServiceProtocol {
    private var restAPIService: RestAPIServiceProtocol

    public init(apiKey: String) throws {
        let restAPIService = try RestAPIService(withAPIKey: apiKey)
        self.restAPIService = restAPIService
    }
    
    @available(iOS 13, *)
    @available(macOS 10.15, *)
    public func getToken() async throws -> Token {
        // 
        let restAPIToken: TRestAPIToken = try await self.restAPIService.getToken()

        // Build the token
        let token: Token = Token(
            bayonetID: restAPIToken.bayonetID
        )

        return token

        /*
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Token, Error>) in
            let token: Token = Token(
                bayonetID: "a-bayonet-id-generated"
            )
            sleep(10)
            continuation.resume(returning: token)
        }
        */
    }
}
