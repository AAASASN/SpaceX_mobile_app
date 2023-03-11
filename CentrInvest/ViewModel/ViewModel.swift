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
    
    let url = "https://api.spacexdata.com/v5/launches"
    
    var networkManager: NetworkManagerProtocol?
    
    var bag = DisposeBag()
    
    private var selectedIndexPath: IndexPath?
    
    var observableValueForReloadTableView: BehaviorRelay<Bool>? = BehaviorRelay(value: false)
    
    var launches: [Launch]! {
        didSet {
            
            guard var x = observableValueForReloadTableView?.value else { return }
            observableValueForReloadTableView?.accept(!x)
            
            
            guard let launches = launches, !launches.isEmpty   else { return }
            print("")
            print("DidSet во ViewModel - значение launches[0] : ")
            print("name - \(String(describing: launches[0].name))")
            print("flightNumber - \(String(describing: launches[0].flightNumber))")
            print("date - \(String(describing: launches[0].dateUtc))")
            print("launches success - \(String(describing: launches[0].success))")
            print("imageLink small = \(String(describing: launches[0].links?.patch?.small))")
            print("cores flight count - \(String(describing: launches[0].cores?[0]?.flight))")
            print("ships names array - \(launches[0].ships)")
            print("")
            print("launches.count \(launches.count)")
            print("")


        }
    }
    
    init() {
        launches = []
        networkManager = NetworkManager()
        networkManager?.getLaunchesToViewModel(url: url)
        
        networkManager?.launchesArray?.asObservable().subscribe(onNext: { value in
            if !value.isEmpty {
                print("Значение value прищло во ViewModel : ")
                print("someValue = \(String(describing: value[0])) ")
            }
            self.launches = value
        }).disposed(by: bag)
                
    }
      
    func numberOfRows() -> Int {
        return launches.count
    }
            
    func cellViewModelCreate(forIndexPath indexPath: IndexPath) -> TableViewCellViewModel? {
        let launch = launches[indexPath.row]
        return TableViewCellViewModel(launch: launch)
    }
    
//    func viewModelForSelectedRow() -> DetailViewModelType? {
//        guard let selectedIndexPath = selectedIndexPath else { return nil }
//        return DetailViewModel(profile: profiles[selectedIndexPath.row])
//    }
    
//    func selectRow(atIndexPath indexPath: IndexPath) {
//        self.selectedIndexPath = indexPath
//    }

}
