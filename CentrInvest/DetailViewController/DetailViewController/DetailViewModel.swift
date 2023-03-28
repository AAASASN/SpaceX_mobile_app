//
//  DetailViewModel.swift
//  CentrInvest
//
//  Created by Александр Мараенко on 14.03.2023.
//

import Foundation
import RxSwift
import RxRelay
import Alamofire

class DetailViewModel {
    
    var launch: Launch
    var crew: [CrewMember]?
    
//    var missionName: String?
//    var missionLargeImageAsString: String?
//    var details: String?
//    var missionStatus: Bool?
//    var missionDate: String?

    var observableMissionName: BehaviorRelay<String>? = BehaviorRelay(value: "")
    var observableMissionLargeImage: BehaviorRelay<UIImage>? = BehaviorRelay(value: UIImage())
    
    var observableYoutubeID: BehaviorRelay<String>? = BehaviorRelay(value: "")

    var observableFlightNumber: BehaviorRelay<String>? = BehaviorRelay(value: "")
    var observableMissionSuccess: BehaviorRelay<(String, UIColor, CGFloat)>? = BehaviorRelay(value: ("", .systemGray3, 0))
    var observableLaunchDate: BehaviorRelay<String>? = BehaviorRelay(value: "")
    var observableCoresLaunchesCount: BehaviorRelay<String>? = BehaviorRelay(value: "")
    var observableCrew: BehaviorRelay<[CrewMember]>? = BehaviorRelay(value: [])

    
    
    init(launch: Launch) {
        self.launch = launch
        
        observableMissionName?.accept(launch.name ?? "error name")
        
        getUIImage(urlAsString: launch.links?.patch.large ?? "")
        
        observableYoutubeID?.accept(launch.links?.youtubeId ?? "error_youtubeID")

    }
    
    func getUIImage(urlAsString: String) {
        AF.request(urlAsString).responseData { response in
            switch response.result {
            case .success(let data) :
                if let image = UIImage(data: data) {
                    self.observableMissionLargeImage?.accept(image)
                }
            case .failure(let error):
                print("Ошибка \(error)")
            }
        }
    }
    
    func getYouTubeTableViewCellViewModel() -> YouTubeTableViewCellViewModel {
        let youTubeTableViewCellViewModel = YouTubeTableViewCellViewModel(youTubeID: launch.links?.youtubeId ?? "error_youtube_id")
        return youTubeTableViewCellViewModel
    }

    
    
}
