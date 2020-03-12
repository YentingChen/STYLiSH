//
//  LobbyViewViewModel.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/3/12.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//
import Foundation

class LobbyViewViewModel {
    
    let lobbyCells = Bindable([[LobbyTableViewCellType]]())
    
    let lobbyHeaders = Bindable([LobbyTableViewHeaderType]())
    
    let appServerClient: AppServerClient
    
    init(appServerClient: AppServerClient = AppServerClient()) {
        self.appServerClient = appServerClient
    }
    
    func getHots() {
        appServerClient.getMarketingHots { [weak self] (result) in
            switch result {
            case .success(let result):
                guard result.data.count > 0 else {
                    self?.lobbyCells.value = [[.empty]]
                    self?.lobbyHeaders.value = [.empty]
                    return
                }
                let hotItems = result.data
                var cellValues = [[LobbyTableViewCellType]]()
                for hotItem in hotItems {
                    let value = hotItem.products.compactMap({
                        LobbyTableViewCellType.normal(viewModel: $0 as LobbyTableViewCellViewModel)
                    })
                    cellValues.append(value)
                }
                self?.lobbyCells.value = cellValues
                self?.lobbyHeaders.value = hotItems.compactMap({
                    LobbyTableViewHeaderType.normal(viewModel: $0 as LobbyTableViewHeaderViewModel)
                })
                
            case .failure(let errorReason):
                switch errorReason {
                case .serverError(let data):
                    self?.lobbyCells.value = [[.error(data: data)]]
                default:
                    break
                }
            }
        }
    }
   
}

enum LobbyTableViewCellType {
    case normal(viewModel: LobbyTableViewCellViewModel)
    case error(data: Data?)
    case empty
}

enum LobbyTableViewHeaderType {
    case normal(viewModel: LobbyTableViewHeaderViewModel)
    case error(data: Data?)
    case empty
}
