import Foundation

/// Represents the possible errors that can be thrown from a Network Transport
public enum NetErrors: Error {
    case invalidURL, invalidResponse
}
