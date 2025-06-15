//
//  MazeNetworkClient.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//
import Foundation

protocol NetworkClient {
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void)
}

class MazeNetworkClient: NetworkClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
// swiftlint:disable function_body_length
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = endpoint.urlRequest else {
            completion(.failure(APIError.invalidURL))
            return
        }
        session.dataTask(with: request) { data, response, error in
            NetworkLogger.log(.info, message: "Fetch Shows API called",
                              urlRequest: request,
                              response: response,
                              data: data,
                              error: error)
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                    GlobalErrorHandler.shared.showError(error.localizedDescription)
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(APIError.noData))
                }
                return
            }
            if !(200...299).contains(httpResponse.statusCode) {
                var errorMessage = "A server error occurred."
                if let data = data,
                   let apiError = try? JSONDecoder().decode(MazeErrorResponse.self, from: data) {
                    errorMessage = apiError.message
                }
                DispatchQueue.main.async {
                    completion(.failure(APIError.serverError(
                        statusCode: httpResponse.statusCode,
                        message: errorMessage)
                    ))
                    GlobalErrorHandler.shared.showError(errorMessage)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(APIError.noData))
                    GlobalErrorHandler.shared.showError("No data received from server.")
                }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(APIError.decodingError))
                    GlobalErrorHandler.shared.showError("Failed to decode response.")
                }
            }
        }.resume()
    }
}
