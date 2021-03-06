//
//  MainViewModel.swift
//  PryanikyTest
//
//  Created by Михаил Задорожный on 05.03.2021.
//

import UIKit

class MainViewModel: MainViewModelProtocol {
    
    var info = Info()
    
    var numberOfRowsInSection: Int {
        
        var counter = 0
        
        guard let rows = info.view, rows.count > 0 else {  return 0 }
        
        rows.forEach { row in
            counter = counter + 1
        }
        
        return counter
    }
    
    var cellNames: [String] {
        
        var nameArray: [String] = []
        
        guard let rows = info.view, rows.count > 0 else {  return [] }
        
        rows.forEach { name in
            nameArray.append(name)
        }
        
        return nameArray
    }
    
    func loadData(completion: @escaping ()->()) {
        
        Networking.getJSON() { [weak self] info in
            
            self?.info = info
            completion()
        }
    }
    
    func cellName(for indexPath: IndexPath) -> String {
        
        let index = indexPath.row
        
        if cellNames.count > index {
            return cellNames[index]
        }
        
        else {
            return "No information"
        }
    }
    
    var cellInfoArray: [InfoData] {
        
        var infoArray: [InfoData] = []
        
        guard let infoData = info.data else {  return [] }
        
        infoData.forEach { data in
            
            infoArray.append(data)
        }
        
        return infoArray
    }
    
    func getInfo(by index: IndexPath) -> InfoData {
        
        let name = cellName(for: index)
        
        var filtered: [InfoData] = []
        
        switch name {
        
        case "hz":
            filtered = cellInfoArray.filter { $0.name == "hz"}
            
        case "picture":
            filtered = cellInfoArray.filter { $0.name == "picture"}
            
        case "selector":
            filtered = cellInfoArray.filter { $0.name == "selector"}
            
        default:
            filtered = []
        }
        
        guard let infoData = filtered.first  else { return InfoData() }
        
        return infoData
    }
    
    func cellHeight(by index: IndexPath) -> CGFloat {
        
        let name = cellName(for: index)
        
        if name == "hz" {
            return 50
        }
        
        if name == "picture" {
            return 300
        }
        
        if name == "selector" {
            return 170
        }
        
        return 50
    }
    
    func createCell(by index: IndexPath, tableView: UITableView) -> UITableViewCell {
        
        let name = cellName(for: index)
        
        var cell = UITableViewCell()
        
        if name == "hz" {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "TextBlockCell") as? TextBlockCell ?? UITableViewCell()
            return cell
        }
        
        if name == "picture" {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "CellWithImage") as? CellWithImage ?? UITableViewCell()
            
            return cell
        }
        
        if name == "selector" {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "CellWithSelector") as? CellWithSelector ?? UITableViewCell()
            
            return cell
        }
        
        return UITableViewCell() 
    }
}
