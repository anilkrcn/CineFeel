protocol MovieRepository{
    func fetchTrending(page: Int) async throws -> MovieResponse
    func search(query: String) async throws -> MovieResponse
    func fetchDetail(id: Int) async throws -> MovieDetail
}
