//
//  HTTPClient.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/2/12.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum STHTTPClientError: Error {
    case decodeDataFail
    case clientError(Data)
    case serverError
    case unexpectedError
}

enum STHTTPMethod: String {
    case GET
    case POST
}

enum STHTTPHeaderField: String {
    case contentType = "Content-Type"
    case auth = "Authorization"
}

enum STHTTPHeaderValue: String {

    case json = "application/json"
}

protocol STRequest {
    
    var headers: [String: String] { get }
    var body: Data? { get }
    var method: String { get }
    var endPoint: String { get }
}

extension STRequest {
    
    func makeRequest() -> URLRequest {

        let urlString = Bundle.STValueForString(key: STConstant.urlKey) + endPoint

        let url = URL(string: urlString)!

        var request = URLRequest(url: url)

        request.allHTTPHeaderFields = headers
        
        request.httpBody = body

        request.httpMethod = method

        return request
    }
}

class HTTPClient {
    
    static let shared = HTTPClient()
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private init() {}
    
    func request(request: STRequest, completion: @escaping (Result<Data>) -> Void) {
        
        URLSession.shared.dataTask(with: request.makeRequest()) { (data, response, error) in
            guard error == nil else {
                return completion(Result.failure(error!))
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            let statusCode = httpResponse.statusCode
            switch statusCode {
            case 200..<300:
                completion(Result.success(data ?? Data()))
            case 400..<500:
                completion(Result.failure(STHTTPClientError.clientError(data ?? Data())))
            case 500..<600:
                completion(Result.failure(STHTTPClientError.serverError))
            default:
                completion(Result.failure(STHTTPClientError.unexpectedError))
                return
            }
            
        }.resume()
    }
}

extension Bundle {
    // swiftlint:disable force_cast
    static func STValueForString(key: String) -> String {
        
        return Bundle.main.infoDictionary![key] as! String
    }

    static func STValueForInt32(key: String) -> Int32 {

        return Bundle.main.infoDictionary![key] as! Int32
    }
    // swiftlint:enable force_cast
}

enum STMarketRequest: STRequest {

    case hots

    case women(paging: Int)

    case men(paging: Int)

    case accessories(paging: Int)

    var headers: [String: String] {

        switch self {

        case .hots, .women, .men, .accessories: return [:]

        }
    }

    var body: Data? {

        switch self {

        case .hots, .women, .men, .accessories: return nil

        }
    }

    var method: String {

        switch self {

        case .hots, .women, .men, .accessories: return STHTTPMethod.GET.rawValue

        }
    }

    var endPoint: String {

        switch self {

        case .hots: return "/marketing/hots"

        case .women(let paging): return "/products/women?paging=\(paging)"

        case .men(let paging): return "/products/men?paging=\(paging)"

        case .accessories(let paging): return "/products/accessories?paging=\(paging)"

        }
    }

}

struct STSuccessParser<T: Codable>: Codable {

    let data: T

    let paging: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case data
        
        case paging = "next_paging"
    }
}

struct STFailureParser: Codable {

    let errorMessage: String
}

struct STConstant {

    static let tapPayAppID = "STTapPayAppID"

    static let tapPayAppKey = "STTapPayAppKey"

    static let urlKey = "STBaseURL"
}
