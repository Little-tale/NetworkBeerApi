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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerListCollectionView.delegate = self
        beerListCollectionView.dataSource = self
        
        beerListCollectionView.register(xib, forCellWithReuseIdentifier: BeerCollectionViewCell.identi)

        setLayOut(CollectionView: beerListCollectionView)
        
        
        
    }


}

extension BeerListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.identi, for: indexPath) as! BeerCollectionViewCell
        
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
