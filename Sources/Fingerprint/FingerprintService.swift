import Foundation
public struct Fingerprint: FingerprintServiceProtocol {
    public private(set) var text = "Hello, World!"

    public init() {
    }
    
    @available(macOS 10.15, *)
    public func getToken() async throws -> Token {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Token, Error>) in
                    let token: Token = Token(
                        bayonetID: "vallonet"
                    )

                    sleep(100)

                    continuation.resume(returning: token)
                }
    }
}

