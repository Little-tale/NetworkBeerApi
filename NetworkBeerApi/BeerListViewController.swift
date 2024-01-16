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

let beermodel = BeerModel()

class BeerListViewController: UIViewController {
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var beerListCollectionView : UICollectionView!
    
    var beerList: [Beer] = [] {
        didSet{
            beerListCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        beermodel.request { beers in
            self.beerList = beers
        }
        
        beerListCollectionView.delegate = self
        beerListCollectionView.dataSource = self
        
        beerListCollectionView.register(xib, forCellWithReuseIdentifier: BeerCollectionViewCell.identi)

        setLayOut(CollectionView: beerListCollectionView)
       
        
        titleLabel.text = "맥주리스트"
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 24)
    }
}


extension BeerListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.identi, for: indexPath) as! BeerCollectionViewCell
        
        let url = URL(string: beerList[indexPath.row].image_url)
        
        cell.beerImageView.kf.setImage(with: url)
        
        cell.beerNameTextField.text = beerList[indexPath.row].name
        cell.beerSubTextField.text =  beerList[indexPath.row].description
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
