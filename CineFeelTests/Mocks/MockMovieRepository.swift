import Foundation


final class MockMovieRepository: MovieRepository {

    var result: Result<MovieResponse, Error>!

    func fetchTrending(page: Int) async throws -> MovieResponse {
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        case .none:
            fatalError("Result not set")
        }
    }

    func search(query: String) async throws -> MovieResponse {
        fatalError("Not needed")
    }

    func fetchDetail(id: Int) async throws -> MovieDetail {
        fatalError("Not needed")
    }
}
