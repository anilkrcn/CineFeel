import Foundation
import Combine

@MainActor
final class SearchMovieViewModel: ObservableObject{
    @Published var searchText = ""
    @Published var movies: [Movie] = []
    @Published var state: ViewState = .idle
    
    private let repository: MovieRepository
    //private let networkService: NetworkService
    private var searchTask: Task<Void, Never>?
    
    
    init(repository: MovieRepository = DefaultMovieRepository(
        networkService: NetworkManager()
    )) {
        self.repository = repository
    }
    
    func searchMovies() {
        searchTask?.cancel()
        
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else{
            movies = []
            state = .idle
            return
        }
        
        searchTask = Task{
            
            do{
                state = .loading
                try await Task.sleep(for: .milliseconds(400))
                
                let response = try await repository.search(query: searchText)
                
                if Task.isCancelled {return}
                
                movies = response.results
                state = movies.isEmpty ? .empty : .loaded
                
            }catch{
                if error is CancellationError{
                    return
                }
                state = .error(.unknown)
            }
        }
        
    }
}
