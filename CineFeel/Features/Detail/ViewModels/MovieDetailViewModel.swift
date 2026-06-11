import Foundation
import Combine

@MainActor
final class MovieDetailViewModel: ObservableObject{
    @Published var movie: MovieDetail?
    @Published var state: ViewState = .idle
    
    private let repository: MovieRepository
    let movieID: Int
    
    init(movieID: Int, repository: MovieRepository = DefaultMovieRepository(
        networkService: NetworkManager()
    )){
        self.movieID = movieID
        self.repository = repository
    }
    
    func fetchMovieDetail() async {
        state = .loading
        do{
            let response = try await repository.fetchDetail(id: movieID)
            movie = response
            state = .loaded
        }catch let error as AppError{
            state = .error(error)
        } catch {
            state = .error(.unknown)
        }
    }

}

