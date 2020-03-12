//
//  AppServerClient.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/3/12.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//
import Alamofire

class AppServerClient {
    
    typealias GetMarketingHotsFailureResult = STResult <Hots, GetMarketingHotsFailureReason>
    typealias GetMarketingHotsCompletion = (_ result: GetMarketingHotsFailureResult) -> Void
    
    func getMarketingHots(completion: @escaping GetMarketingHotsCompletion) {
        let urlString = "https://api.appworks-school.tw/api/1.0/marketing/hots"
        Alamofire.request(urlString).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else {
                        completion(.failure(nil))
                        return
                    }
                    
                    let hots = try JSONDecoder().decode(Hots.self, from: data)
                    completion(.success(payload: hots))
                
                } catch {
                    completion(.failure(nil))
                }
            case .failure(_):
                if let statusCode = response.response?.statusCode, let reason = GetMarketingHotsFailureReason(rawValue: (statusCode, nil), data: nil) {
                    completion(.failure(reason))
                }
                completion(.failure(nil))
            }
        }
    }
    
}

enum STResult<T, U: Error> {
    case success(payload: T)
    case failure(U?)
}

enum EmptyResult<U: Error> {
    case success
    case failure(U?)
}

// MARK: - AppServerClient
enum GetMarketingHotsFailureReason: Error {
    case serverError(data: Data?)
    func getErrorMessage() -> String? {
        switch self {
        case .serverError:
            return "Server Error Response"
        }
        
    }
}

extension GetMarketingHotsFailureReason: RawRepresentable {
    
    init?(rawValue: (Int, Int?)) {
        switch rawValue.0 {
        case 500: self = .serverError(data: nil)
        default:
            return nil
        }
    }
    
    public typealias RawValue = (Int, Int?)
    public init?(rawValue: RawValue, data: Data?) {
        switch rawValue.0 {
        case 500: self = .serverError(data: nil)
        default:
            return nil
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .serverError: return (500, nil)
        
        }
    }
    
}
