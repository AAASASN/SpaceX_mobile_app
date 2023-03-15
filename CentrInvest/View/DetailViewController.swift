//
//  DetailViewController.swift
//  CentrInvest
//
//  Created by Александр Мараенко on 14.03.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailViewModel: DetailViewModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let url = URL(string: detailViewModel.launch.links?.patch?.small ?? "") else { return }
        
        guard let data = try? Data(contentsOf: url) else { return }
       
        
        guard let image = UIImage(data: data) else { return }
        let imageView = UIImageView(image: image)
        imageView.center = view.center
        view.addSubview(imageView)
        
    }


}
