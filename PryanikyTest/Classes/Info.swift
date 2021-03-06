//
//  Info.swift
//  PryanikyTest
//
//  Created by Михаил Задорожный on 05.03.2021.
//

import Foundation

struct Info: Decodable {
    var data: [InfoData]?
    var view: [String]?
}

struct InfoData: Decodable {
    var name: String?
    var data: DetailData?
}

struct DetailData: Decodable {
    var text: String?
    var url: String?
    var selectedId: Int?
    var variants: [Variant]?
}

struct Variant: Decodable {
    var id: Int?
    var text: String?
}
