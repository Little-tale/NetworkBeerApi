//
//  ModelManager.swift
//  NetworkBeerApi
//
//  Created by Jae hyung Kim on 1/17/24.
//

import UIKit
import Alamofire

enum urlEnum: String {
    case BeerList = "https://api.punkapi.com/v2/beers"
}


struct Beer: Decodable{
    let image_url: String
    let name: String
    let description: String
}


struct BeerModel {
    func request( compliet: @escaping ([Beer]) -> () ) {
        
        AF.request(urlEnum.BeerList.rawValue, method: .get).responseDecodable(of: [Beer].self ) {
            response in
            switch response.result {
            case .success(let success):
                compliet(success)
            case .failure(let failure):
                print("문제발생")
            }
        }
    }
}
