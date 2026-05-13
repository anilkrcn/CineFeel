import Foundation
import Combine

@MainActor
final class SearchMovieViewModel: ObservableObject{
    @Published var searchText = ""
    @Published var movies: [Movie] = []
    @Published var state: ViewState = .idle
    
    private let networkManager = NetworkManager()
    
    private var searchTask: Task<Void, Never>?
    
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
                
                let response = try await networkManager.fetch(endpoint: SearchMovieEndpoint(query: searchText), type: MovieResponse.self)
                
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
