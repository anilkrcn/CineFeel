import Foundation

enum AppError: LocalizedError {

    case invalidURL
    case invalidResponse
    case decodingError
    case serverError
    case unknown

    var errorDescription: String? {

        switch self {

        case .invalidURL:
            return "Invalid request."

        case .invalidResponse:
            return "Invalid server response."

        case .decodingError:
            return "Failed to process data."

        case .serverError:
            return "Server error occurred."

        case .unknown:
            return "Something went wrong."
        }
    }
}
