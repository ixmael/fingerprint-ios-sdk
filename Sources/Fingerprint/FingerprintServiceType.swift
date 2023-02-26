import Foundation

struct Token {
    let bayonetID: String
}

@available(macOS 10.15.0, *)
protocol FingerprintServiceProtocol {
    func getToken() async throws -> Token
}
