import SwiftUI


struct MovieDetailView: View {

    @StateObject private var viewModel: MovieDetailViewModel

    init(movieID: Int) {
        _viewModel = StateObject(
            wrappedValue: MovieDetailViewModel(movieID: movieID)
        )
    }

    var body: some View {

        ScrollView {

            content
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchMovieDetail()
        }
    }

    @ViewBuilder
    private var content: some View {

        switch viewModel.state {

        case .idle, .loading:

            ProgressView()

        case .loaded:

            if let movie = viewModel.movie {

                VStack(alignment: .leading, spacing: 16) {

                    AsyncImage(url: movie.backdropURL) { image in

                        image
                            .resizable()
                            .scaledToFill()

                    } placeholder: {

                        ProgressView()
                    }
                    .frame(height: 220)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 16)
                    )

                    VStack(alignment: .leading, spacing: 8) {

                        Text(movie.title)
                            .font(.title2.bold())

                        Text(movie.releaseDate)
                            .foregroundStyle(.secondary)

                        Text(movie.overview)
                    }
                }
                .padding()
            }

        case .empty:

            EmptyView()

        case .error(let error):

            Text(error.localizedDescription)
        }
    }
}
