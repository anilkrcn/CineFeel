final class DefaultMovieRepository: MovieRepository{
    

    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchTrending(page: Int) async throws -> MovieResponse {
        let endpoint = TrendingMoviesEndpoint(page: page)
        return try await networkService.fetch(endpoint: endpoint, type: MovieResponse.self)
    }
    
    func search(query: String) async throws -> MovieResponse {
        let endpoint = SearchMovieEndpoint(query: query)
        return try await networkService.fetch(endpoint: endpoint, type: MovieResponse.self)
    }
}

