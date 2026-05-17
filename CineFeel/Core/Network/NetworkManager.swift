import Foundation

final class NetworkManager: NetworkService {

    func fetch<T: Decodable>(
        endpoint: Endpoint,
        type: T.Type
    ) async throws -> T {

        var components = URLComponents(
            string: Constants.baseURL + endpoint.path
        )

        components?.queryItems = endpoint.queryItems

        guard let url = components?.url else {
            throw AppError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse else {
            throw AppError.invalidResponse
        }

        guard 200...299 ~= response.statusCode else {
            throw AppError.serverError
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw AppError.decodingError
        }
    }
}
