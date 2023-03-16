//
//  MainViewController.swift
//  CentrInvest
//
//  Created by Александр Мараенко on 01.03.2023.
//

import UIKit
import RxSwift
import RxCocoa


class MainViewController: UIViewController{
    
    var tableView: UITableView!
    var bag = DisposeBag()
    private var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        navigationItem.title = "SpaceX"
        tableViewSettings()
        
        viewModel.observableValueForReloadTableView?.asObservable().subscribe { boolValie in
            print("tableView.reloadData()")
            self.tableView.reloadData()
        }.disposed(by: bag)
        
        view.backgroundColor = .systemBackground

    }

}

extension MainViewController {
    
    // MARK: - tableViewSettings
    func tableViewSettings() {
        
        
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                                    ])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")

        tableView.backgroundColor = .clear
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.missionIconImage.image = nil
        cell.tableViewCellViewModel = viewModel.cellViewModelCreate(forIndexPath: indexPath)
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        300
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let viewModel = viewModel else { return }
        
        let detailViewController = DetailViewController()
        detailViewController.detailViewModel = viewModel.detailViewModelCreate(forIndexPath: indexPath)
        navigationController?.pushViewController(detailViewController, animated: true)

    }
}
