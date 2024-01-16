//
//  BeerListViewController.swift
//  NetworkBeerApi
//
//  Created by Jae hyung Kim on 1/16/24.
//

import UIKit
import Kingfisher // 이미지
import Alamofire // 서버랑 대화 Response


let xib = UINib(nibName: BeerCollectionViewCell.identi, bundle: nil)



class BeerListViewController: UIViewController {
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var beerListCollectionView : UICollectionView!
    
    var beerList: [BeerElemet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerListCollectionView.delegate = self
        beerListCollectionView.dataSource = self
        
        beerListCollectionView.register(xib, forCellWithReuseIdentifier: BeerCollectionViewCell.identi)

        setLayOut(CollectionView: beerListCollectionView)
        for i in 0...10 {
            setResponse()
        }
        
        titleLabel.text = "맥주리스트"
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 24)
    }
}

extension BeerListViewController {
    func setResponse() {
        
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).responseDecodable(of: [BeerElemet].self) { response in
            switch response.result {
            case .success(let success):
                self.beerList.append(contentsOf: success)
                self.beerListCollectionView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
}



extension BeerListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // setResponse()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.identi, for: indexPath) as! BeerCollectionViewCell
       
//        guard let urlSemple = beerList.popLast()?.image_url else {
//            return cell
//        }
//        let url = URL(string: urlSemple)
//       
//        cell.beerImageView.kf.setImage(with: url)
        // 만약 인덱스 패스 행 < 맥주리스트 갯수
        if indexPath.row < beerList.count {
            let beer = beerList[indexPath.row]
            if let imageURL = URL(string: beer.image_url) {
                cell.beerImageView.kf.setImage(with: imageURL)
            }
            cell.beerNameTextField.text = beer.name
            cell.beerSubTextField.text = beer.description
        }
        return cell
    }
    
}

extension BeerListViewController {
    func setLayOut(CollectionView : UICollectionView) {
        
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        print(screenWidth)
        let horspacing: CGFloat = 14
        let verSpacing: CGFloat = 14
        
        let fullWidth = screenWidth - ( verSpacing * 3)
        let cellWidth = fullWidth / 2
        
        print(cellWidth)
        layout.itemSize = CGSize(width: cellWidth, height: 280)
        layout.sectionInset = UIEdgeInsets(top: horspacing, left: verSpacing, bottom: horspacing, right: verSpacing)
        
        
        CollectionView.collectionViewLayout = layout
    }
}
