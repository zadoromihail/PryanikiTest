//
//  CellProtocol.swift
//  PryanikyTest
//
//  Created by Михаил Задорожный on 06.03.2021.
//

import Foundation

protocol CellProtocol {
    var infoData: InfoData { get set }
    var variantChosed: ((String) -> ())? { get set }
    func configure(with info: InfoData)
}
