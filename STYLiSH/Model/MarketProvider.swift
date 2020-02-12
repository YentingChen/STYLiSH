//
//  MarketProvider.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/2/12.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//

import Foundation

class MarketProvider {
    
    let decoder = JSONDecoder()
    
    private enum ProductType {
        
        case men(Int)
        
        case women(Int)
        
        case accessories(Int)
    }
    
    typealias PromotionHanlder = (Result<[PromotedProducts]>) -> Void
    func fetchHots(completion: @escaping PromotionHanlder) {
        HTTPClient.shared.request(request: STMarketRequest.hots) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
                
            case .success( let data):
                do {
                    let products = try strongSelf.decoder.decode(STSuccessParser<[PromotedProducts]>.self, from: data)
                    DispatchQueue.main.async {
                       completion(Result.success(products.data))
                    }
                    
                } catch {
                    completion(Result.failure(error))
                }
            case .failure(let error):
                completion(Result.failure(error))
    
            }
        }
    }
}
