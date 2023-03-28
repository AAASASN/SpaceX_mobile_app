//
//  NetworkManager.swift
//  CentrInvest
//
//  Created by Александр Мараенко on 01.03.2023.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import Moya

protocol NetworkManagerProtocol {
//    func fetchData(url: String)
    func fetchData(getMoyaSevice: MoyaSevice)

    var launchesArray: BehaviorRelay<[Launch]>?  { get set }
    var crew: BehaviorRelay<[CrewMember]>? { get set }
//    var someLaunch: BehaviorRelay<[Launch]>? { get set }
}

class NetworkManager: NetworkManagerProtocol {

    
    private let service = MoyaProvider<MoyaSevice>()
    
    let bag = DisposeBag()
    
    var launchesArray: BehaviorRelay<[Launch]>? = BehaviorRelay(value: [])
    var crew: BehaviorRelay<[CrewMember]>? = BehaviorRelay(value: [])
//    var someLaunch: BehaviorRelay<[Launch]>? = BehaviorRelay(value: [])

//    func getLaunchesToViewModel(url: String){
//        fetchData(getMoyaSevice: .getLaunches)
//    }

//    internal func fetchData(url: String) {
//
//        AF.request(url).responseData { response in
//            switch response.result {
//            case .success(let data) :
//                do {
//                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase // конвертация на лету в кемелкейс
//                    let missions = try decoder.decode([Launch].self, from: data )
//
//                    print("")
//                    print("fetchData отработал, пришло значение, missions[0] =  ")
//                    print(missions[0])
//                    print("")
//                    print("затем принятое значение присваивается self.launchesArray ")
//
//                    self.launchesArray?.accept(missions)
//
//
//                } catch let error {
//                    print("JSONDecoder не отработал \(error)")
//                }
//            case .failure(let error):
//                print("Ошибка \(error)")
//            }
//        }
//
//    }
    
    internal func fetchData(getMoyaSevice: MoyaSevice) {

        service.rx.request(getMoyaSevice).subscribe { [weak self] event in
            switch event {
            case let .success(response):
                print("response")
                print(response.data)
                let data = response.data
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase // конвертация на лету в кемелкейс

                    if getMoyaSevice == .getLaunches {
                        let missions = try decoder.decode([Launch].self, from: data )

                        print("")
                        print("fetchData отработал, пришло значение, missions[0] =  ")
                        print(missions[0])
                        print("")
                        print("затем принятое значение присваивается self.launchesArray ")

                        self?.launchesArray?.accept(missions)
                    }

                    if getMoyaSevice == .getCrew {
                        let crew = try decoder.decode([CrewMember].self, from: data )

                        print("")
                        print("fetchData отработал, пришло значение, crew[0] =  ")
                        print(crew[0])
                        print("")
                        print("затем принятое значение присваивается self.crew ")

                        self?.crew?.accept(crew)
                    }

                } catch let error {
                    print("JSONDecoder не отработал \(error)")
                }
            case .failure(let error):
                print("fetchData(getMoyaSevice: ) \(error.localizedDescription)")
            }
        }.disposed(by: bag)
    }

}



enum MoyaSevice: Equatable {
    
    case getLaunches
    case getCrew
    
}

extension MoyaSevice : TargetType {
    
    var headers: [String: String]? {
        let headers: [String: String] = [
            "Accept": "application/json"
        ]
        
        return headers
    }
    
    var baseURL: URL {
        return URL(string: "https://api.spacexdata.com/\(version)")!
    }
    
    var version: String {
        switch self {
        case .getLaunches:
            return "v5"
        case .getCrew:
            return "v4"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    var path: String {
        switch self {
            
        case .getLaunches:
            return "/launches"
        case .getCrew:
            return "/crew"
        }
    }
    
    var task: Task {
        switch self {
        case .getLaunches:
            return .requestPlain
        case .getCrew:
            return .requestPlain
        }

    }
    

}
