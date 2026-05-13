import Foundation

struct MovieDetail: Decodable {

    let id: Int
    let title: String
    let overview: String
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

extension MovieDetail {

    var backdropURL: URL? {

        URL(
            string: "https://image.tmdb.org/t/p/w780\(backdropPath ?? "")"
        )
    }
}
