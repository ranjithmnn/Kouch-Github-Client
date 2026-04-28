//
//  NetworkError.swift
//  Kouch
//
//  Created by Ranjith Menon on 28/04/2026.
//

import Foundation

/// Strongly-typed errors for the networking layer.
nonisolated enum NetworkError: LocalizedError {
    case badURL
    case httpError(statusCode: Int)
    case noData
    case decodingFailed(Error)
    case unauthorized
    case forbidden
    case notFound
    case rateLimited(resetDate: Date?)
    case serverError(statusCode: Int)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Invalid URL. Please check the endpoint configuration."
        case .httpError(let statusCode):
            return "HTTP error \(statusCode): \(Self.descriptionForStatusCode(statusCode))"
        case .noData:
            return "The server returned an empty response."
        case .decodingFailed(let error):
            return "Failed to parse response: \(error.localizedDescription)"
        case .unauthorized:
            return "Authentication failed. Please check your GitHub API token."
        case .forbidden:
            return "Access denied. You may not have permission to view this resource."
        case .notFound:
            return "The requested resource was not found."
        case .rateLimited(let resetDate):
            if let resetDate {
                let formatter = RelativeDateTimeFormatter()
                let relative = formatter.localizedString(for: resetDate, relativeTo: Date())
                return "GitHub API rate limit exceeded. Resets \(relative)."
            }
            return "GitHub API rate limit exceeded. Please try again later."
        case .serverError(let statusCode):
            return "GitHub server error (\(statusCode)). Please try again later."
        case .unknown(let error):
            return error.localizedDescription
        }
    }

    /// Maps an HTTP status code to a specific `NetworkError`.
    static func fromStatusCode(_ statusCode: Int, headers: [AnyHashable: Any]? = nil) -> NetworkError? {
        switch statusCode {
        case 200...299:
            return nil // Success — no error
        case 401:
            return .unauthorized
        case 403:
            // Check for rate limiting via X-RateLimit-Remaining header
            if let remaining = headers?["X-RateLimit-Remaining"] as? String, remaining == "0" {
                var resetDate: Date?
                if let resetStr = headers?["X-RateLimit-Reset"] as? String,
                   let resetTimestamp = TimeInterval(resetStr) {
                    resetDate = Date(timeIntervalSince1970: resetTimestamp)
                }
                return .rateLimited(resetDate: resetDate)
            }
            return .forbidden
        case 404:
            return .notFound
        case 422:
            return .httpError(statusCode: statusCode)
        case 500, 502, 503:
            return .serverError(statusCode: statusCode)
        default:
            return .httpError(statusCode: statusCode)
        }
    }

    private static func descriptionForStatusCode(_ code: Int) -> String {
        switch code {
        case 400: return "Bad Request"
        case 401: return "Unauthorized"
        case 403: return "Forbidden"
        case 404: return "Not Found"
        case 422: return "Unprocessable Entity"
        case 429: return "Too Many Requests"
        case 500: return "Internal Server Error"
        case 502: return "Bad Gateway"
        case 503: return "Service Unavailable"
        default: return HTTPURLResponse.localizedString(forStatusCode: code)
        }
    }
}
