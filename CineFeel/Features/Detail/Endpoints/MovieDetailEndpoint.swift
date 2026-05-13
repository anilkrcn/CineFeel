import Foundation

struct MovieDetailEndpoint: Endpoint{
    let movieID: Int
    var path: String{
        "/movie/\(movieID)"
    }
    
    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "api_key", value: Constants.apiKey)
        ]
    }
    
    
}

