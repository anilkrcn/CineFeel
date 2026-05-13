import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Trending")
        }
        .task {
            await viewModel.fetchTrendingMovies()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
        case .loaded:
            List(viewModel.movies) { movie in
                NavigationLink{
                    MovieDetailView(movieID: movie.id)
                } label: {
                    MovieCardView(movie: movie)
                }
                .onAppear{
                    if movie == viewModel.movies.last{
                        Task{
                            await viewModel.fetchTrendingMovies()
                        }
                    }
                }
            }
        case .empty:
            ContentUnavailableView("No Movies", image: "film")
            
        case .error(let error):
        VStack(spacing: 12){
            Text("Something went wrong")
            Text(error.localizedDescription)
            Button("Retry"){
                Task{
                    await viewModel.fetchTrendingMovies()
                }
            }
        }
        }
        
    }
}
