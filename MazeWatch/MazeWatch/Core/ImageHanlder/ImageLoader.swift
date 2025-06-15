//
//  ImageLoader.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 14/06/25.
//

import UIKit

final class ImageLoader {

    static let shared = ImageLoader()

    private let cache = NSCache<NSString, UIImage>()
    private let defaultImageName = "Image"

    private init() {}

    // Keep reference to tasks to allow cancellation
    private var runningTasks = [URL: URLSessionDataTask]()

    @discardableResult
    func load(from urlString: String, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return nil
        }

        guard let url = URL(string: urlString) else {
            completion(defaultImage())
            return nil
        }

        // Cancel previous task for this URL if any
        runningTasks[url]?.cancel()

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            DispatchQueue.main.async {
                defer { self?.runningTasks[url] = nil }

                if let data = data, let image = UIImage(data: data) {
                    self?.cache.setObject(image, forKey: urlString as NSString)
                    completion(image)
                } else {
                    completion(self?.defaultImage())
                }
            }
        }
        runningTasks[url] = task
        task.resume()

        return task
    }

    private func defaultImage() -> UIImage? {
        return UIImage(named: defaultImageName)
    }
}
