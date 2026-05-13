import Foundation
import Combine

@MainActor
final class MovieDetailViewModel: ObservableObject{
    @Published var movie: MovieDetail?
    @Published var state: ViewState = .idle
    
    private let networkManager = NetworkManager()
    
    let movieID: Int
    
    init(movieID: Int){
        self.movieID = movieID
    }
    
    func fetchMovieDetail() async {
        state = .loading
        do{
            let response = try await networkManager.fetch(endpoint: MovieDetailEndpoint(movieID: movieID), type: MovieDetail.self)
            movie = response
            state = .loaded
        }catch let error as AppError{
            state = .error(error)
        } catch {
            state = .error(.unknown)
        }
    }

}

