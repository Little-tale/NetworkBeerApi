//
//  ViewController.swift
//  NetworkBeerApi
//
//  Created by Jae hyung Kim on 1/16/24.
//

import UIKit
import Alamofire
import WebKit
import Kingfisher
/*
 NetworkBeerApi.BeerElemet
   - name: "Mango And Chili Barley Wine"
   - imageURL: "https://images.punkapi.com/v2/keg.png"
   - description: "A huge, chewy barley wine, loaded with bitterness and balanced with a sweet and spicy combo of
 */


// https://api.punkapi.com/v2/beers/random
class ViewController: UIViewController {
    @IBOutlet var recommendLabel: UILabel!
    @IBOutlet var beerNameLabel: UILabel!
    @IBOutlet var beerDetailLabel: UILabel!
    @IBOutlet var recommendButton: UIButton!
    @IBOutlet var beerImgeView: UIImageView!
    
    
    // var test: beerElement
    
    var beer: [BeerElemet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        request()
    }
    
    @IBAction func randomButtonAct(_ sender: UIButton) {
        request()
    }
}


extension ViewController {
    func request() {
        let url = "https://api.punkapi.com/v2/beers/random"
        // default : .get, statusCode: 200...299 // 500~서버오류
        AF.request(url, method: .get).responseDecodable(of: [BeerElemet].self ) { response in
            switch response.result {
            case .success(let success):
                if let test = success.first{
                    print("asdasd")
                    self.beerNameLabel.text = test.name
                    self.beerDetailLabel.text = test.description
                    if let url = URL(string: test.image_url) {
                        let request = URLRequest(url: url)
                        self.beerImgeView.kf.setImage(with: url)
                    }
                }
                
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
