import UIKit

final class DefaultImageLoader: ImageLoader {

    private let cache = ImageCache.shared

    func loadImage(from url: URL) async -> UIImage? {

        // 1. Cache check
        if let cached = cache.get(url) {
            return cached
        }
        // 2. Download
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            guard let image = UIImage(data: data) else {
                return nil
            }
            // 3. Cache store
            cache.set(image, for: url)
            return image
        } catch {
            return nil
        }
    }
}
