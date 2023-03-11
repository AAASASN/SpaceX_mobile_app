//
//  TableViewCellViewModel.swift
//  CentrInvest
//
//  Created by Александр Мараенко on 01.03.2023.
//

import Foundation
import UIKit

class TableViewCellViewModel {
    
    private var launch: Launch

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
        guard let coresLaunchesCount = launch.cores?[0]?.flight else { return "error mission.cores?[0]?.flight " }
        return "Сore flight - " + String(coresLaunchesCount)
    }

    var missionSuccess: String {
        guard let launchSuccess = launch.success else { return "error mission.success"}
        return launchSuccess == true ? "Success" : "Fail"
    }
    
    var flightNumber: String {
        guard let flightNumber = launch.flightNumber else { return "error flightNumber" }
        return "#" + String(flightNumber)
    }
    
    var launchDate: String {
        guard let dateUtc = launch.dateUtc else { return "error guard let dateUtc = launch.dateUtc"}
        let dateFormater = dateFormaterCreator()
        guard let date = dateFormater.date(from: dateUtc) else { return "error1" }
        
        dateFormater.dateFormat = "MM/dd/yyyy"
        let str = dateFormater.string(from: date)
        return str
    }
    
    func dateFormaterCreator() -> DateFormatter {
        // для корректного формата даты
        let dateFormatter = DateFormatter()
        // настроим локализацию - для отображения на русском языке
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        // настроим вид отображения даты в текстовом виде
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }
}
