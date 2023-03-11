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

protocol NetworkManagerProtocol {
    func getLaunchesToViewModel(url: String)
    var launchesArray: BehaviorRelay<[Launch]>?  { get set }
}

class NetworkManager: NetworkManagerProtocol {
    
    var launchesArray: BehaviorRelay<[Launch]>? = BehaviorRelay(value: [])
    
    func getLaunchesToViewModel(url: String){
        fetchData(url: url)
    }

    private func fetchData(url: String) {

        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data) :
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase // конвертация на лету в кемелкейс
                    let missions = try decoder.decode([Launch].self, from: data )
                    
                    print("")
                    print("fetchData отработал, пришло значение, missions[0] =  ")
                    print(missions[0])
                    print("")
                    print("затем принятое значение присваивается self.launchesArray ")
                     
                    self.launchesArray?.accept(missions)
                    

                } catch let error {
                    print("JSONDecoder не отработал \(error)")
                }
            case .failure(let error):
                print("Ошибка \(error)")
            }
        }

    }

}






