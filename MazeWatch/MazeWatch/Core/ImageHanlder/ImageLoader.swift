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

    /// Nome da imagem default no Assets (ex: "Image")
    private let defaultImageName = "Image"

    private init() {}

    func load(from urlString: String, completion: @escaping (UIImage) -> Void) {
        // Retorna imagem do cache se existir
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }

        // Cria URL válida
        guard let url = URL(string: urlString) else {
            completion(defaultImage())
            return
        }

        // Faz download da imagem
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: urlString as NSString)
                    completion(image)
                } else {
                    completion(self.defaultImage())
                }
            }
        }.resume()
    }

    private func defaultImage() -> UIImage {
        return UIImage(named: defaultImageName) ?? UIImage()
    }
}
