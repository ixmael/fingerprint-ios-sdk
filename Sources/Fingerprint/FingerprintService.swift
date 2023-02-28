import Foundation

import FingerprintPro

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

        let metadata = Metadata()
        metadata.setTag(restAPIToken.bayonetID, forKey: "browserToken")
        if restAPIToken.environment != nil {
            metadata.setTag(restAPIToken.environment, forKey: "environment")
        }

        let fingerprintproService = FingerprintProFactory.getInstance(restAPIToken.services.fingerprintjs.apiKey)

        do {
            let fingerprintproDeviceID = try await fingerprintproService.getVisitorId()
        } catch {
            print("error", error as Any)
        }

        // Build the token
        let token: Token = Token(
            bayonetID: restAPIToken.bayonetID,
            environment: restAPIToken.environment
        )

        return token
    }
}
