//
//  YouTubeTableViewCellViewModel.swift
//  CentrInvest
//
//  Created by Александр Мараенко on 22.03.2023.
//

import Foundation
import RxRelay

class YouTubeTableViewCellViewModel {
    
    let youTubeID: String
    
    var observableYouTubeID: BehaviorRelay<String>? = BehaviorRelay(value: "")
    
    init(youTubeID: String) {
        self.youTubeID = youTubeID
        setSubscribe()
    }
    
    func setSubscribe() {
        observableYouTubeID?.accept(youTubeID)
    }
    
}
