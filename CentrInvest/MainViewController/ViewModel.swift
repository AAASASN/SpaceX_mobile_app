//
//  ViewModel.swift
//  CentrInvest
//
//  Created by Александр Мараенко on 01.03.2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ViewModel {
        
    var networkManager: NetworkManagerProtocol?
    
    var bag = DisposeBag()
    
    private var selectedIndexPath: IndexPath?
    
    var observableValueForReloadTableView: BehaviorRelay<Bool>? = BehaviorRelay(value: false)
    
    var launches: [Launch]! {
        didSet {
            
            guard let x = observableValueForReloadTableView?.value else { return }
            observableValueForReloadTableView?.accept(!x)
            
            
            guard let launches = launches, !launches.isEmpty   else { return }
            print("")
            print("DidSet во ViewModel - значение launches[0] : ")
            print("name - \(String(describing: launches[0].name))")
            print("flightNumber - \(String(describing: launches[0].flightNumber))")
            print("date - \(String(describing: launches[0].dateUtc))")
            print("launches success - \(String(describing: launches[0].success))")
            print("imageLink small = \(String(describing: launches[0].links?.patch.small))")
            print("cores flight count - \(String(describing: launches[0].cores?[0]?.flight))")
            print("ships names array - \(launches[0].ships)")
            print("")
            print("youtube small = \(String(describing: launches[0].links?.webcast))")
            print("launches.count \(launches.count)")
            print("")
        }
    }
    
    var crew: [CrewMember]! {
        didSet {
            
            guard let x = observableValueForReloadTableView?.value else { return }
            observableValueForReloadTableView?.accept(!x)
            
            guard let crew = crew, !crew.isEmpty   else { return }
            print("")
            print("DidSet во ViewModel - значение crew[0] : ")
            print("name - \(String(describing: crew[0].name))")
            print("id - \(String(describing: crew[0].id))")
            print("")
            print("crew.count \(crew.count)")
            print("")
        }
    }
    
    init() {
        launches = []
        networkManager = NetworkManager()
        networkManager?.fetchData(getMoyaSevice: .getLaunches)
        networkManager?.fetchData(getMoyaSevice: .getCrew)
//        networkManager?.fetchData(url: "https://api.spacexdata.com/v4/launches")
//        networkManager?.fetchData(url: <#T##String#>)
        
        
        networkManager?.launchesArray?.asObservable().subscribe(onNext: { launchesArrayValue in
            if !launchesArrayValue.isEmpty {
                print("Значение value-launchesArray прищло во ViewModel : ")
                print("someValue = \(String(describing: launchesArrayValue[0])) ")
            }
            self.launches = launchesArrayValue
        }).disposed(by: bag)
    }
      
    func numberOfRows() -> Int {
        return launches.count
    }
            
    func cellViewModelCreate(forIndexPath indexPath: IndexPath) -> TableViewCellViewModel? {
        let launch = launches[indexPath.row]
        return TableViewCellViewModel(launch: launch)
    }
    
    func detailViewModelCreate(forIndexPath indexPath: IndexPath) -> DetailViewModel? {
        let launch = launches[indexPath.row]
        return DetailViewModel(launch: launch)
    }

}
