import Foundation
public struct Fingerprint: FingerprintServiceProtocol {
    public private(set) var text = "Hello, World!"

    public init() {
    }
    
    @available(macOS 10.15, *)
    public func getToken() async throws -> Token {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Token, Error>) in
                    let token: Token = Token(
                        bayonetID: "a-bayonet-id-generated"
                    )

                    sleep(10)

                    continuation.resume(returning: token)
                }
    }
}

