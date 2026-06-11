import UIKit

final class InFlightImageRequests {

    static let shared = InFlightImageRequests()
    private init() {}

    private var tasks: [URL: Task<UIImage?, Never>] = [:]
    private let lock = NSLock()

    func task(for url: URL,
              operation: @escaping () async -> UIImage?) -> Task<UIImage?, Never> {

        lock.lock()
        defer { lock.unlock() }

        if let existingTask = tasks[url] {
            return existingTask
        }

        let task = Task { () -> UIImage? in
            defer {
                self.remove(url)
            }
            return await operation()
        }

        tasks[url] = task
        return task
    }

    private func remove(_ url: URL) {
        lock.lock()
        tasks.removeValue(forKey: url)
        lock.unlock()
    }
}
