import Foundation

struct Movie: Decodable, Identifiable, Equatable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
    }
}

struct MovieResponse: Decodable{
    let page: Int
    let results: [Movie]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}

extension Movie {

    var posterURL: URL? {
        URL(
            string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
        )
    }
}
