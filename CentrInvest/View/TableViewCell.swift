//
//  TableViewCell.swift
//  CentrInvest
//
//  Created by Александр Мараенко on 01.03.2023.
//

import UIKit
import Alamofire
import RxSwift

class TableViewCell: UITableViewCell {
    
    var bag = DisposeBag()
        
    var missionIconImage: UIImageView!
    var missionIconImageAsString: String!
    var missionNameLabel: UILabel!
    
    var flightNumberLabel: UILabel!
    var missionSuccessLabel: UIButton!
    
    var launchDateLabel: UILabel!
    var coresLaunchesCountLabel: UILabel!
    
    
    weak var tableViewCellViewModel: TableViewCellViewModel? {
        willSet(tableViewCellViewModel) {
            
            guard let tableViewCellViewModel = tableViewCellViewModel else { return }
                        
            tableViewCellViewModel.observableMissionName?.asObservable().subscribe(onNext: { nameAsString in
                self.missionNameLabel.text = nameAsString
            }).disposed(by: bag)

            
            tableViewCellViewModel.observableFlightNumber?.asObservable().subscribe(onNext: { flightNumberAsString in
                self.flightNumberLabel.text = flightNumberAsString
            }).disposed(by: bag)
            
            
            tableViewCellViewModel.observableMissionSuccess?.asObservable().subscribe(onNext: { missionSuccessParamTuple in
                self.missionSuccessLabel.setTitle(missionSuccessParamTuple.0, for: .normal)
                self.missionSuccessLabel.backgroundColor = missionSuccessParamTuple.1
                self.missionSuccessLabel.frame.size.width = missionSuccessParamTuple.2
            }).disposed(by: bag)
            
            
            tableViewCellViewModel.observableLaunchDate?.asObservable().subscribe(onNext: { launchDateAsString in
                self.launchDateLabel.text = launchDateAsString
            }).disposed(by: bag)
            
            tableViewCellViewModel.observableCoresLaunchesCount?.asObservable().subscribe(onNext: { coresLaunchesCountAsString in
                self.coresLaunchesCountLabel.text = coresLaunchesCountAsString
            }).disposed(by: bag)

            missionIconImageAsString = tableViewCellViewModel.missionIconImage
            getUIImage(urlAsString: missionIconImageAsString)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createCellElements()
        addElementsToView()
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCellElements() {
        missionIconImage = {
            let missionIconImage = UIImageView(image: UIImage(systemName: ""))
            missionIconImage.frame = CGRect(x: 15, y: 15, width: 100, height: 100)

            return missionIconImage
        }()
        
        missionNameLabel = {
            let missionNameLabel = UILabel(frame: CGRect(x: 130, y: 15, width: self.contentView.frame.maxX - missionIconImage.frame.origin.x - 30, height: 25))
            
            missionNameLabel.numberOfLines = 0
            missionNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
            return missionNameLabel
        }()
        
        flightNumberLabel = {
            let flightNumberLabel = UILabel(frame: CGRect(x: 130, y: 45, width: 45, height: 20))
            return flightNumberLabel
        }()
        
        missionSuccessLabel = {
            let missionSuccessLabel = UIButton(frame: CGRect(x: 130, y: 70, width: 80, height: 20))
            missionSuccessLabel.titleLabel?.textColor = .white
            missionSuccessLabel.titleLabel?.font = .boldSystemFont(ofSize: 18)
            missionSuccessLabel.layer.cornerRadius = 5
            return missionSuccessLabel
        }()
        
        launchDateLabel = {
            let launchDateLabel = UILabel(frame: CGRect(x: 130, y: 95, width: 95, height: 20))
            return launchDateLabel
        }()
        
        coresLaunchesCountLabel = {
            let coresFlightLabel = UILabel(frame: CGRect(x: 230, y: 95, width: contentView.frame.width - 180, height: 20))
            
            coresFlightLabel.textColor = .systemGray
            return coresFlightLabel
        }()

    }
    
    
    func addElementsToView() {
        contentView.addSubview(flightNumberLabel)
        contentView.addSubview(missionSuccessLabel)
        contentView.addSubview(launchDateLabel)
        contentView.addSubview(coresLaunchesCountLabel)
        contentView.addSubview(missionNameLabel)
        contentView.addSubview(missionIconImage)
    }

    func getUIImage(urlAsString: String) {
        AF.request(urlAsString).responseData { response in
            
            switch response.result {
            case .success(let data) :
                if let image = UIImage(data: data) {
                    
                    if response.request?.url?.description == self.missionIconImageAsString {
                        self.missionIconImage.image = image
                    }
                }
                
            case .failure(let error):
                print("Ошибка \(error)")
            }
        }
    }
    
}
