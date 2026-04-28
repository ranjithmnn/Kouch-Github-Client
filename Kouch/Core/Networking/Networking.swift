//
//  Networking.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation
import os

/// Centralized networking client using async/await with generic decoding.
/// Marked nonisolated to opt out of the project's default MainActor isolation —
/// network operations should run off the main thread.
nonisolated final class APINetworking: Sendable {

    static let shared = APINetworking()

    private let session: URLSession
    private let logger = Logger(subsystem: "com.app.Kouch", category: "Networking")

    /// Shared JSON decoder configured for GitHub API responses.
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    init(session: URLSession = .shared) {
        self.session = session
    }

    /// Fetches and decodes a response from the given endpoint.
    ///
    /// - Parameter endpoint: The API endpoint to call.
    /// - Returns: The decoded model of type `T`.
    /// - Throws: `NetworkError` for HTTP, decoding, or connectivity failures.
    func fetch<T: Decodable & Sendable>(_ endpoint: APIEndpoint) async throws -> T {
        let request = await endpoint.urlRequest

        logger.debug("➡️ \(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "nil")")

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(for: request)
        } catch {
            logger.error("❌ Network error: \(error.localizedDescription)")
            throw NetworkError.unknown(error)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            logger.error("❌ Invalid response type (not HTTPURLResponse)")
            throw NetworkError.noData
        }

        logger.debug("⬅️ \(httpResponse.statusCode) (\(data.count) bytes)")

        // Check for HTTP-level errors
        if let networkError = NetworkError.fromStatusCode(
            httpResponse.statusCode,
            headers: httpResponse.allHeaderFields
        ) {
            // Log the response body for debugging non-2xx responses
            if let body = String(data: data, encoding: .utf8) {
                logger.error("❌ Error body: \(body)")
            }
            throw networkError
        }

        // Decode the response
        do {
            let decoded = try Self.decoder.decode(T.self, from: data)
            return decoded
        } catch {
            logger.error("❌ Decoding error: \(error)")
            throw NetworkError.decodingFailed(error)
        }
    }
}
