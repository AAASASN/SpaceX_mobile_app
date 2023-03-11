//
//  TableViewCell.swift
//  CentrInvest
//
//  Created by Александр Мараенко on 01.03.2023.
//

import UIKit
import Alamofire

class TableViewCell: UITableViewCell {
    
    var missionIconImage: UIImageView!
    var missionNameLabel: UILabel!
    
    var flightNumberLabel: UILabel!
    var missionSuccessLabel: UILabel!
    
    var launchDateLabel: UILabel!
    var coresLaunchesCountLabel: UILabel!
    
    var stackView4: UIStackView!
    
    weak var tableViewCellViewModel: TableViewCellViewModel? {
        willSet(tableViewCellViewModel) {
            
            guard let tableViewCellViewModel = tableViewCellViewModel else { return }
            
            missionNameLabel.text = tableViewCellViewModel.missionName
            coresLaunchesCountLabel.text = tableViewCellViewModel.coresLaunchesCount
            missionSuccessLabel.text = tableViewCellViewModel.missionSuccess
            launchDateLabel.text = tableViewCellViewModel.launchDate
            flightNumberLabel.text = tableViewCellViewModel.flightNumber
            getUIImageView(urlAsString: tableViewCellViewModel.missionIconImage)
        }
    }
    
    func getUIImageView(urlAsString: String) {
        AF.request(urlAsString).responseData { response in
            switch response.result {
            case .success(let data) :
                    let image = UIImage(data: data)
                    self.missionIconImage.image = image
            case .failure(let error):
                print("Ошибка \(error)")
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createCellElements()
        addElementsToView()
        setElementsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCellElements() {
        
        missionIconImage = {
            let missionIconImage = UIImageView(image: UIImage(systemName: ""))
            return missionIconImage
        }()
        
        missionNameLabel = {
            let missionNameLabel = UILabel(frame: .zero)
            missionNameLabel.numberOfLines = 0
            missionNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
            return missionNameLabel
        }()
        
        coresLaunchesCountLabel = {
            let coresFlightLabel = UILabel(frame: .zero)
            
            coresFlightLabel.textColor = .systemGray3
            return coresFlightLabel
        }()
        
        missionSuccessLabel = {
            let missionSuccessLabel = UILabel(frame: .zero)
            missionSuccessLabel.textColor = .systemGreen
            missionSuccessLabel.font = UIFont.boldSystemFont(ofSize: 18)
            return missionSuccessLabel
        }()
        
        launchDateLabel = {
            let launchDateLabel = UILabel(frame: .zero)
            return launchDateLabel
        }()
        
        flightNumberLabel = {
            let flightNumberLabel = UILabel(frame: .zero)
            return flightNumberLabel
        }()
        
    }
    
    
    func addElementsToView() {
        
        let stackView1 = UIStackView()
        stackView1.axis = .horizontal
        stackView1.distribution = .equalSpacing
        stackView1.alignment = .fill
        stackView1.spacing = 10

        let stackView2 = UIStackView()
        stackView2.axis = .horizontal
        stackView2.distribution = .equalSpacing
        stackView2.alignment = .fill
        stackView2.spacing = 10

        let stackView3 = UIStackView()
        stackView3.axis = .vertical
        stackView3.distribution = .fill
        stackView3.alignment = .leading
        stackView3.spacing = 0
//        stackView3.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([stackView3.heightAnchor.constraint(equalToConstant: 40)])


        stackView4 = {
            let stackView4 = UIStackView()
            stackView4.axis = .horizontal
            stackView4.distribution = .fill
            stackView4.alignment = .fill
            stackView4.spacing = 15
            return stackView4
        }()

        stackView4.translatesAutoresizingMaskIntoConstraints = false
//
        missionIconImage.translatesAutoresizingMaskIntoConstraints = false
//        missionNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        coresLaunchesCountLabel.translatesAutoresizingMaskIntoConstraints = false
//        missionSuccessLabel.translatesAutoresizingMaskIntoConstraints = false
//        launchDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView1.addArrangedSubview(flightNumberLabel)
        stackView1.addArrangedSubview(missionSuccessLabel)
        
        stackView2.addArrangedSubview(launchDateLabel)
        stackView2.addArrangedSubview(coresLaunchesCountLabel)

        stackView3.addArrangedSubview(missionNameLabel)
        stackView3.addArrangedSubview(stackView1)
        stackView3.addArrangedSubview(stackView2)
        
        stackView4.addArrangedSubview(missionIconImage)
        stackView4.addArrangedSubview(stackView3)

        contentView.addSubview(stackView4)

//        contentView.addSubview(missionIconImage)
//        contentView.addSubview(missionNameLabel)
//        contentView.addSubview(coresLaunchesCountLabel)
//        contentView.addSubview(missionSuccessLabel)
//        contentView.addSubview(launchDateLabel)
        

    }
    
    func setElementsConstraints() {
        
        
        NSLayoutConstraint.activate([
            
            
            
            stackView4.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            stackView4.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            stackView4.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            stackView4.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15),
            //stackView4.widthAnchor.constraint(equalToConstant: 130),
            
            
//            missionIconImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
//            missionIconImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
//            missionIconImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            missionIconImage.widthAnchor.constraint(equalToConstant: 100),
            missionIconImage.heightAnchor.constraint(equalToConstant: 100),

//
//            missionNameLabel.leadingAnchor.constraint(equalTo: self.missionIconImage.trailingAnchor, constant: 5),
//            missionNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
//            missionNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
//            missionNameLabel.heightAnchor.constraint(equalToConstant: 30),
//
//            coresLaunchesCountLabel.leadingAnchor.constraint(equalTo: self.missionIconImage.trailingAnchor, constant: 5),
//            coresLaunchesCountLabel.topAnchor.constraint(equalTo: self.missionNameLabel.bottomAnchor, constant: 5),
//            coresLaunchesCountLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
//            coresLaunchesCountLabel.heightAnchor.constraint(equalToConstant: 30),
//
//            missionSuccessLabel.leadingAnchor.constraint(equalTo: self.missionIconImage.trailingAnchor, constant: 5),
//            missionSuccessLabel.topAnchor.constraint(equalTo: self.coresLaunchesCountLabel.bottomAnchor, constant: 5),
//            missionSuccessLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
//            missionSuccessLabel.heightAnchor.constraint(equalToConstant: 30),
//
//            launchDateLabel.leadingAnchor.constraint(equalTo: self.missionIconImage.trailingAnchor, constant: 5),
//            launchDateLabel.topAnchor.constraint(equalTo: self.missionSuccessLabel.bottomAnchor, constant: 5),
//            launchDateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
//            launchDateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
//            launchDateLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }

    
}
