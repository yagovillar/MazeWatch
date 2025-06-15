//
//  MazeNetworkClient.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//
import Foundation

protocol NetworkClient {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

class MazeNetworkClient: NetworkClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            guard let request = endpoint.urlRequest else {
                continuation.resume(throwing: APIError.invalidURL)
                return
            }

            session.dataTask(with: request) { data, response, error in
                NetworkLogger.log(.info, message: "API called",
                                  urlRequest: request,
                                  response: response,
                                  data: data,
                                  error: error)

                if let error = error {
                    DispatchQueue.main.async {
                        GlobalErrorHandler.shared.showError(error.localizedDescription)
                        continuation.resume(throwing: error)
                    }
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        GlobalErrorHandler.shared.showError("No response from server")
                        continuation.resume(throwing: APIError.noData)
                    }
                    return
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    var errorMessage = "Server error: \(httpResponse.statusCode)"
                    if let data = data,
                       let apiError = try? JSONDecoder().decode(MazeErrorResponse.self, from: data) {
                        errorMessage = apiError.message
                        if let previousError = apiError.previous {
                            errorMessage += " - Previous error: \(previousError.message)"
                        }
                    }
                    DispatchQueue.main.async {
                        GlobalErrorHandler.shared.showError(errorMessage)
                        continuation.resume(throwing: MazeError.serverError(httpResponse.statusCode, errorMessage))
                    }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        GlobalErrorHandler.shared.showError("No data received")
                        continuation.resume(throwing: APIError.noData)
                    }
                    return
                }

                do {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    }
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decoded = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        continuation.resume(returning: decoded)
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        GlobalErrorHandler.shared.showError("Failed to decode response: \(error.localizedDescription)")
                        continuation.resume(throwing: APIError.decodingError)
                    }
                }
            }.resume()
        }
    }

}
