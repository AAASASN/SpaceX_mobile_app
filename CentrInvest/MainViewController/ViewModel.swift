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
    
    enum Scope: Int {
        case past, upcoming
    }
        
    var networkManager: NetworkManagerProtocol?
    
    var bag = DisposeBag()
    
    private var selectedIndexPath: IndexPath?
    
    let scope: BehaviorRelay<Scope>? = BehaviorRelay<Scope>(value: .past)
    private let pastLaunches = BehaviorRelay<[Launch]>(value: [])
    private let futureLaunches = BehaviorRelay<[Launch]>(value: [])
    
    // в searchText будет передаваться значение добавленное в строку поиска searchController
    var searchText: BehaviorRelay<String> = BehaviorRelay<String>(value: "")

    // сюда будут помещаться список [Launch] соответствцуюций параметру searchText
    var filteredLaunches: [Launch]! {
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

    var observableValueForReloadTableView: BehaviorRelay<Bool>? = BehaviorRelay(value: false)
    
    var launches: [Launch]! {
        didSet {
            
            guard let x = observableValueForReloadTableView?.value else { return }
            observableValueForReloadTableView?.accept(!x)
            
            
            guard let launches = launches, !launches.isEmpty   else { return }
            
            filteredLaunches = launches
            
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
        
//        //
//        let scopeDataSourceObservable = scope?.asObservable().map { [weak self] scope -> [Launch]? in
//            switch scope {
//            case .upcoming: return self?.futureLaunches.value
//            case .past: return self?.pastLaunches.value
//            }
//        }
//
//        guard let checkedScopeDataSourceObservable = scopeDataSourceObservable else {
//            return
//        }
        
        
        searchText.asObservable().subscribe(onNext: { word in

            var newArray: [Launch] = []
            for launch in self.launches {
                if ((launch.name?.contains(word)) != nil) {
                    newArray.append(launch)
                }
            }
            if !newArray.isEmpty {
                self.filteredLaunches = newArray
            } else {
                self.filteredLaunches = self.launches
            }
            
        }).disposed(by: bag)

    }
      
    func numberOfRows() -> Int {
        return launches.count
    }
            
    func cellViewModelCreate(forIndexPath indexPath: IndexPath) -> TableViewCellViewModel? {
        let launch = filteredLaunches[indexPath.row] // launches[indexPath.row]
        return TableViewCellViewModel(launch: launch)
    }
    
    func detailViewModelCreate(forIndexPath indexPath: IndexPath) -> DetailViewModel? {
        let launch = launches[indexPath.row]
        return DetailViewModel(launch: launch)
    }

}
