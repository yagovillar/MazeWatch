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

    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = endpoint.urlRequest else {
            completion(.failure(APIError.invalidURL))
            return
        }

        session.dataTask(with: request) { data, response, error in
            NetworkLogger.log(.info, message: "Fetch Shows API called", urlRequest: request, response: response, data: data, error: error)

            if let error = error {
                completion(.failure(error))
                GlobalErrorHandler.shared.showError(error.localizedDescription)
                return
            }

            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {

                var errorMessage = "A server error occurred."
                if let data = data {
                    if let apiError = try? JSONDecoder().decode(MazeErrorResponse.self, from: data) {
                        errorMessage = apiError.message
                    }
                }

                completion(.failure(APIError.serverError(statusCode: httpResponse.statusCode, message: errorMessage)))
                return
            }

            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(APIError.decodingError))
            }
        }.resume()
    }

}
