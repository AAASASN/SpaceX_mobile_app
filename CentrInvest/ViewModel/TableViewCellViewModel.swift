//
//  TableViewCellViewModel.swift
//  CentrInvest
//
//  Created by Александр Мараенко on 01.03.2023.
//

import Foundation
import UIKit
import Alamofire
import RxRelay

class TableViewCellViewModel {
    
    var launch: Launch

    init(launch: Launch) {
        self.launch = launch
        setSubscribe()
    }

    var missionIconImage: String {
        return launch.links?.patch?.small ?? "error image"
    }
    
    var observableMissionName: BehaviorRelay<String>? = BehaviorRelay(value: "")
    var observableFlightNumber: BehaviorRelay<String>? = BehaviorRelay(value: "")
    var observableMissionSuccess: BehaviorRelay<(String, UIColor, CGFloat)>? = BehaviorRelay(value: ("", .systemGray3, 0))
    var observableLaunchDate: BehaviorRelay<String>? = BehaviorRelay(value: "")
    var observableCoresLaunchesCount: BehaviorRelay<String>? = BehaviorRelay(value: "")
    
    func dateFormat(firstDate: String?) -> String {
        guard let firstDate = firstDate else { return "date_error_1"}
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: firstDate) else { return "date_error_2" }
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let str = dateFormatter.string(from: date)
        return str
    }

    func setSubscribe() {
        observableMissionName?.accept(launch.name ?? "error name")
        observableCoresLaunchesCount?.accept("Сore flight - " + String(launch.cores?[0]?.flight ?? 0))
        observableMissionSuccess?.accept(launch.success == true ? ("Success", .systemGreen, 80) : ("Fail", .systemRed, 40))
        observableFlightNumber?.accept("#" + String(launch.flightNumber ?? 0))
        observableLaunchDate?.accept( dateFormat(firstDate: launch.dateUtc) )
    }
}
