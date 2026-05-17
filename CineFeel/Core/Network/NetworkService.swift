protocol NetworkService{
    func fetch<T: Decodable>(
        endpoint: Endpoint,
        type: T.Type
    ) async throws -> T
}

