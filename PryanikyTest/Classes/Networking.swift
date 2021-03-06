//
//  Networking.swift
//  PryanikyTest
//
//  Created by Михаил Задорожный on 05.03.2021.
//

import Foundation
import Alamofire

class Networking {

    static let urlString = "https://pryaniky.com/static/json/sample.json"
    
    static func getJSON(completion: @escaping (Info)->()) {
    
        DispatchQueue.global().async {
            
            AF.request(urlString, method: .get).response { response in
                
                let decoder = JSONDecoder()
                
                guard let data = response.data else { return }
                
                let info = try? decoder.decode(Info.self, from: data)
                
                guard let safeInfo = info else { return }
                
                completion(safeInfo)
            }
        }
    }
}
