//
//  YouTubeTableViewCell.swift
//  CentrInvest
//
//  Created by Александр Мараенко on 22.03.2023.
//

import UIKit
import YoutubePlayer_in_WKWebView
import RxSwift

class YouTubeTableViewCell: UITableViewCell {

    lazy var playerView: WKYTPlayerView = {
        let playerView = WKYTPlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(playerView)
        NSLayoutConstraint.activate([ playerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0),
                                      playerView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                                      playerView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                                      playerView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 0),
                                      playerView.heightAnchor.constraint(equalToConstant: 400)
                                    ])
        return playerView
    }()
    
    let bag = DisposeBag()
    
    var youTubeTableViewCellViewModel: YouTubeTableViewCellViewModel? {
        
        willSet(youTubeTableViewCellViewModel) {
            
            guard let youTubeTableViewCellViewModel = youTubeTableViewCellViewModel else { return }
            
            youTubeTableViewCellViewModel.observableYouTubeID?.asObservable().subscribe(onNext: { youTubeID in
                self.playerView.load(withVideoId: youTubeID)
            }).disposed(by: bag)
        }
    }
    

    
}
