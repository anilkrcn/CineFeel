import Foundation

struct SearchMovieEndpoint: Endpoint{
    let query: String
    
    var path: String{
        "/search/movie"
    }
    
    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name:"query", value: query )
        ]
    }
}
