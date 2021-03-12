//
//  MainViewModelProtocol.swift
//  PryanikyTest
//
//  Created by Михаил Задорожный on 06.03.2021.
//

import UIKit

protocol MainViewModelProtocol {
    var numberOfSections: Int { get }
    func numberOfRowsInSection(section: Int) -> Int
    func loadData(completion: @escaping ()->())
    func getInfo(by index: IndexPath) -> InfoData
    func cellHeight(by indexPath: IndexPath) -> CGFloat
    func createCell(by index: IndexPath, tableView: UITableView) -> UITableViewCell
    func titleForHeaderInSection(at index: Int) -> String
}
