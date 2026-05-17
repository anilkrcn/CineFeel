import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject{
    @Published var movies: [Movie] = []
    @Published var state: ViewState = .idle
    
    private var currentPage = 1
    private var totalPages = 1
    
    private var isFetching = false
    private let repository: MovieRepository
    
    init(repository: MovieRepository = DefaultMovieRepository(
        networkService: NetworkManager()
    )) {
        self.repository = repository
    }
    
    func fetchTrendingMovies() async {
        
        guard !isFetching else { return }
        
        guard currentPage <= totalPages else { return }
        
        isFetching = true
        if currentPage == 1 {
            state = .loading
        }
        
        defer{
            isFetching = false
        }
        do {
            let response = try await repository.fetchTrending(page: currentPage)
            movies += response.results
            currentPage += 1
            totalPages = response.totalPages
            state = movies.isEmpty ? .empty : .loaded
        }
        catch  let error as AppError{
           state = .error(error)
        } catch{
            state = .error(.unknown)
        }
    }
}
