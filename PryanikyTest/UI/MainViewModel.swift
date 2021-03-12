//
//  MainViewModel.swift
//  PryanikyTest
//
//  Created by Михаил Задорожный on 05.03.2021.
//

import UIKit

class MainViewModel: MainViewModelProtocol {
    
    private var info = Info()
    private var sections: [[InfoData]] = []
    private var sectionsIsNotEmpty = false
    
    var numberOfSections: Int {
        
        return sections.count
    }
    
    var sectionNames: [String] {
        
        var nameArray: [String] = []
        
        guard let rows = info.view, rows.count > 0 else {  return [] }
        
        rows.forEach { name in
            nameArray.append(name)
        }
        
        return nameArray
    }
    
    private func configureSections() {
        
        info.view?.forEach { _ in sections.append([]) }
        sectionsIsNotEmpty = true
        
        info.data?.forEach { object in
            
            guard let name = object.name else { return }
            
            sectionNames.enumerated().forEach { cellName in
                
                if name == cellName.element {
                    let index = cellName.offset
                    sections[index].append(object)
                }
            }
        }
    }
    
    func titleForHeaderInSection(at index: Int) -> String {
        
        guard !sectionNames.isEmpty else {
            return "No inforamtion"
        }
        return sectionNames[index]
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        
        return sections[section].count
    }
    
    func loadData(completion: @escaping ()->()) {
        
        Networking.getJSON() { [weak self] info in
            
            self?.info = info
            self?.configureSections()
            completion()
        }
    }
    
    func getInfo(by index: IndexPath) -> InfoData {
        
        guard sectionsIsNotEmpty else { return InfoData() }
        
        let infoData = sections[index.section][index.row]
        
        return infoData
    }
    
    func cellHeight(by index: IndexPath) -> CGFloat {
        
        if sectionsIsNotEmpty  {
            
            let name = sections[index.section][index.row].name
            
            if name == "hz" {
                return 50
            }
            
            if name == "picture" {
                return 300
            }
            
            if name == "selector" {
                return 70
            }
        }
        
        return 50
    }
    
    func createCell(by index: IndexPath, tableView: UITableView) -> UITableViewCell {
        
        if sectionsIsNotEmpty {
            
            let name = sections[index.section][index.row].name
            
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
        }
        
        return UITableViewCell()
    }
}
