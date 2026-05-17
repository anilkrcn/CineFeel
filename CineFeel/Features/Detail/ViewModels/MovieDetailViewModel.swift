import Foundation
import Combine

@MainActor
final class MovieDetailViewModel: ObservableObject{
    @Published var movie: MovieDetail?
    @Published var state: ViewState = .idle
    
    private let networkService: NetworkService
    let movieID: Int
    
    init(movieID: Int, networkService: NetworkService = NetworkManager()){
        self.movieID = movieID
        self.networkService = networkService
    }
    
    func fetchMovieDetail() async {
        state = .loading
        do{
            let response = try await networkService.fetch(endpoint: MovieDetailEndpoint(movieID: movieID), type: MovieDetail.self)
            movie = response
            state = .loaded
        }catch let error as AppError{
            state = .error(error)
        } catch {
            state = .error(.unknown)
        }
    }

}

