

import SwiftUI

struct SearchMovieView: View {

    @StateObject private var viewModel = SearchMovieViewModel()

    var body: some View {

        NavigationStack {

            content
                .navigationTitle("Search")
        }
        .searchable(text: $viewModel.searchText)
        .onChange(of: viewModel.searchText) {
            viewModel.searchMovies()
        }
    }

    @ViewBuilder
    private var content: some View {

        switch viewModel.state {

        case .idle:

            ContentUnavailableView(
                "Search Movies",
                systemImage: "magnifyingglass"
            )

        case .loading:

            ProgressView()

        case .loaded:

            List(viewModel.movies) { movie in

                NavigationLink {

                    MovieDetailView(movieID: movie.id)

                } label: {

                    MovieCardView(movie: movie)
                }
            }

        case .empty:

            ContentUnavailableView.search

        case .error(let error):

            Text(error.localizedDescription)
        }
    }
}


