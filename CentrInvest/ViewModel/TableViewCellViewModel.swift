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
    }

    var missionIconImage: String {
        return launch.links?.patch?.small ?? "error image"
    }
    
    var missionName: String {
        return launch.name ?? "error name!!! "
    }
    
    var coresLaunchesCount: String {
        guard let coresLaunchesCount = launch.cores?[0]?.flight else { return "Сore flight - 0" }
        return "Сore flight - " + String(coresLaunchesCount)
    }

    var missionSuccess: String {
        guard let launchSuccess = launch.success else { return "Fail"}
        return launchSuccess == true ? "Success" : "Fail"
    }
    
    var flightNumber: String {
        guard let flightNumber = launch.flightNumber else { return "error flightNumber" }
        return "#" + String(flightNumber)
    }
    
    var launchDate: String {
        guard let dateUtc = launch.dateUtc else { return "error guard let dateUtc = launch.dateUtc"}
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: dateUtc) else { return "error1" }
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let str = dateFormatter.string(from: date)
        return str
    }

}
