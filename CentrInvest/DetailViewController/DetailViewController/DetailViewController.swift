//
//  DetailViewController.swift
//  CentrInvest
//
//  Created by Александр Мараенко on 14.03.2023.
//

import Foundation
import UIKit
import RxSwift
import WebKit

class DetailViewController: UIViewController {

    var detailViewModel: DetailViewModel!

    var tableView: UITableView!

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        tableViewSettings()
        
//        subscrubing()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    func tableViewSettings() {

        tableView = UITableView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0 ),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        tableView.backgroundColor = .clear
        
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = YouTubeTableViewCell()
            cell.selectionStyle = .none
            cell.youTubeTableViewCellViewModel = detailViewModel.getYouTubeTableViewCellViewModel()
            return cell
            
        case 1:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "#" + String(detailViewModel.launch.flightNumber ?? 0)
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
            return cell
            
        case 2:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = detailViewModel.launch.name
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
            return cell
            
        case 3:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "Date: " + (detailViewModel.launch.dateUtc ?? "")
//            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
            return cell
            
        case 4:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "Details: " + (detailViewModel.launch.details ?? "")
            return cell
            
        case 5:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = detailViewModel.launch.links?.article
            return cell
            
        case 6:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = detailViewModel.launch.links?.presskit
            return cell
            
            
        default:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = detailViewModel.launch.links?.wikipedia
            return cell
            
        }
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        ytView
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        400
//    }
    
    
}
