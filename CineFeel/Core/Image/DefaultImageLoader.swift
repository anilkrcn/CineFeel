import UIKit

final class DefaultImageLoader: ImageLoader {

    private let cache = ImageCache.shared
    private let inFlight = InFlightImageRequests.shared

    func loadImage(from url: URL) async -> UIImage? {

        // 1. Cache check
        if let cached = cache.get(url) {
            return cached
        }

        // 2. In-flight deduplication
        let task = inFlight.task(for: url) {
            await self.downloadImage(from: url)
        }

        return await task.value
    }

    private func downloadImage(from url: URL) async -> UIImage? {

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            guard let image = UIImage(data: data) else {
                return nil
            }

            cache.set(image, for: url)

            return image

        } catch {
            return nil
        }
    }
}
