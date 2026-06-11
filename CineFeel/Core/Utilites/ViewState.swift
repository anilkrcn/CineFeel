enum ViewState: Equatable{
    case idle
    case loading
    case loaded
    case empty
    case error(AppError)
}
