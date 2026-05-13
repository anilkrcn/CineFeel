import Foundation

struct TrendingMoviesEndpoint: Endpoint {
    let page: Int
    
    var path: String {
        "/trending/movie/day"
    }

    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "page", value: "\(page)")
        ]
    }
}
