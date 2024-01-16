//
//  ViewController.swift
//  NetworkBeerApi
//
//  Created by Jae hyung Kim on 1/16/24.
//

import UIKit
import Alamofire

// https://api.punkapi.com/v2/beers/random
class ViewController: UIViewController {
    @IBOutlet var recommendLabel: UILabel!
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerNameLabel: UILabel!
    @IBOutlet var beerDetailLabel: UILabel!
    @IBOutlet var recommendButton: UIButton!
    
    // var test: beerElement
    
    override func viewDidLoad() {
        super.viewDidLoad()
       design()
        request()
    }
    
}


extension ViewController {
    func request() {
        let url = "https://api.punkapi.com/v2/beers/random"
        
        AF.request(url, method: .get).responseDecodable(of: beerElement.self ) {
            response in
            switch response.result {
            case .success(let success):
                print(success.name)
                print(success.imageURL)
                print(success.description)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}







// 디자인 영역
extension ViewController {
    func design() {
        recommendLabel.text = "오늘은 이 맥주를 추천합니다!"
        recommendLabel.font = .boldSystemFont(ofSize: 24)
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "cloud")
        config.imagePadding = 8
        recommendButton.configuration = config
        recommendButton.tintColor = .orange
        // recommendLabel.font = .systemFont(ofSize: 8)
        recommendButton.setTitle("다른 맥주 추천 받기", for: .normal)
        recommendButton.titleLabel?.font = .systemFont(ofSize: 14)
        
    }
}
