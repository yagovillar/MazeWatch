//
//  NetworkLogger.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 14/06/25.
//
import Foundation

enum NetworkLogLevel {
    case info
    case warning
    case error
}

final class NetworkLogger {
    static var isEnabled = true

    private static let separator = "──────────────────────────────────────────────"

    private static func color(_ text: String, colorCode: String) -> String {
        return "\(colorCode)\(text)\u{001B}[0m"
    }

    private static let red = "\u{001B}[0;31m"
    private static let green = "\u{001B}[0;32m"
    private static let yellow = "\u{001B}[0;33m"
    private static let cyan = "\u{001B}[0;36m"
    private static let magenta = "\u{001B}[0;35m"

    static func log(_ level: NetworkLogLevel,
                    message: String,
                    urlRequest: URLRequest? = nil,
                    response: URLResponse? = nil,
                    data: Data? = nil,
                    error: Error? = nil) {

        guard isEnabled else { return }

        let (prefix, colorCode) = prefixAndColor(for: level)

        print("\n\(color(separator, colorCode: magenta))")
        print(color("\(prefix) \(message)", colorCode: colorCode))

        if let request = urlRequest {
            logRequest(request)
        }

        if let httpResponse = response as? HTTPURLResponse {
            logResponse(httpResponse)
        }

        if let data = data {
            logResponseBody(data)
        }

        if let error = error {
            logError(error)
        }

        print(color(separator, colorCode: magenta) + "\n")
    }

    private static func prefixAndColor(for level: NetworkLogLevel) -> (String, String) {
        switch level {
        case .info:
            return ("ℹ️ [INFO]", cyan)
        case .warning:
            return ("⚠️ [WARNING]", yellow)
        case .error:
            return ("❌ [ERROR]", red)
        }
    }

    private static func logRequest(_ request: URLRequest) {
        print(color("➡️ Request:", colorCode: green))
        print("   Method: \(request.httpMethod ?? "N/A")")
        print("   URL: \(request.url?.absoluteString ?? "N/A")")

        if let headers = request.allHTTPHeaderFields {
            print("   Headers:")
            for (key, value) in headers {
                print("     • \(key): \(value)")
            }
        }

        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("   Body:\n\(indent(text: bodyString, level: 2))")
        }
    }

    private static func logResponse(_ httpResponse: HTTPURLResponse) {
        print(color("⬅️ Response:", colorCode: green))
        print("   Status Code: \(httpResponse.statusCode)")
        print("   Headers:")
        for (key, value) in httpResponse.allHeaderFields {
            print("     • \(key): \(value)")
        }
    }

    private static func logResponseBody(_ data: Data) {
        guard let responseBody = String(data: data, encoding: .utf8), !responseBody.isEmpty else { return }
        print(color("📦 Response Body:", colorCode: green))
        print(indent(text: responseBody, level: 1))
    }

    private static func logError(_ error: Error) {
        print(color("⚠️ Error: \(error.localizedDescription)", colorCode: red))
    }

    private static func indent(text: String, level: Int) -> String {
        let prefix = String(repeating: "    ", count: level)
        return text
            .split(separator: "\n")
            .map { prefix + $0 }
            .joined(separator: "\n")
    }
}
