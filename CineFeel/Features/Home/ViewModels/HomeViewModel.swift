import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject{
    @Published var movies: [Movie] = []
    @Published var state: ViewState = .idle
    
    private var currentPage = 1
    private var totalPages = 1
    
    private var isFetching = false
    
    private let networkManager = NetworkManager()
    
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
            let response = try await networkManager.fetch(endpoint: TrendingMoviesEndpoint(page: currentPage), type: MovieResponse.self)
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
