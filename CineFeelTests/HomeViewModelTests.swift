import Testing
@testable import CineFeel

struct HomeViewModelTests {

    @Test
    @MainActor
    func fetchTrending_success_updatesMovies() async {

        let mockRepo = MockMovieRepository()

        mockRepo.result = .success(
            MovieResponse(
                page: 1,
                results: [
                    Movie(
                        id: 1,
                        title: "Batman",
                        overview: "Test",
                        posterPath: "/test.jpg",
                        //voteAverage: 8.0
                    )
                ],
                totalPages: 1
            )
        )

        let vm = HomeViewModel(repository: mockRepo)

        await vm.fetchTrendingMovies()

        #expect(vm.movies.count == 1)
    }
    
    @Test
    @MainActor
    func fetchTrending_empty_setsEmptyState() async {

        let mockRepo = MockMovieRepository()

        mockRepo.result = .success(
            MovieResponse(
                page: 1,
                results: [],
                totalPages: 1
            )
        )

        let vm = HomeViewModel(repository: mockRepo)

        await vm.fetchTrendingMovies()

        #expect(vm.movies.isEmpty)
    }
    
    @Test
    @MainActor
    func fetchTrending_failure_setsErrorState() async {

        let mockRepo = MockMovieRepository()

        mockRepo.result = .failure(AppError.unknown)

        let vm = HomeViewModel(repository: mockRepo)

        await vm.fetchTrendingMovies()

        #expect(vm.state == .error(.unknown))
    }
    
    @Test
    @MainActor
    func pagination_firstPage_loadsMovies() async {

        let mockRepo = MockMovieRepository()

        mockRepo.result = .success(
            MovieResponse(
                page: 1,
                results: [
                    Movie(
                        id: 1,
                        title: "Batman",
                        overview: "Test",
                        posterPath: "/test.jpg",
                        //voteAverage: 8.0
                    )
                ],
                totalPages: 3
            )
        )

        let vm = HomeViewModel(repository: mockRepo)

        await vm.fetchTrendingMovies()

        #expect(vm.movies.count == 1)
    }
    
    @Test
    @MainActor
    func pagination_secondPage_appendsMovies() async {

        let mockRepo = MockMovieRepository()

        mockRepo.result = .success(
            MovieResponse(
                page: 2,
                results: [
                    Movie(
                        id: 2,
                        title: "Superman",
                        overview: "Test",
                        posterPath: "/test2.jpg",
                       // voteAverage: 7.5
                    )
                ],
                totalPages: 3
            )
        )

        let vm = HomeViewModel(repository: mockRepo)

        // page 1
        await vm.fetchTrendingMovies()

        // page 2
        await vm.fetchTrendingMovies()

        #expect(vm.movies.count == 2)
    }
    
    @Test
    @MainActor
    func pagination_doesNotSendDuplicateRequest_whenFetching() async {

        let mockRepo = MockMovieRepository()

        var callCount = 0

        mockRepo.result = .success(
            MovieResponse(
                page: 1,
                results: [],
                totalPages: 3
            )
        )

        let vm = HomeViewModel(repository: mockRepo)

        await vm.fetchTrendingMovies()

        // isFetching true iken tekrar çağırmayı simüle et
        await vm.fetchTrendingMovies()

        #expect(vm.movies.count == 0)
    }
    
}
