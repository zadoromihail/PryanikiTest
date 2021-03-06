//
//  MainViewController.swift
//  PryanikyTest
//
//  Created by Михаил Задорожный on 05.03.2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol!
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        configure()
    }
    
    private func setupUI() {
        
        title = "Main"
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TextBlockCell.self, forCellReuseIdentifier: "TextBlockCell")
        tableView.register(CellWithImage.self, forCellReuseIdentifier: "CellWithImage")
        tableView.register(CellWithSelector.self, forCellReuseIdentifier: "CellWithSelector")
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func configure() {
        
        viewModel.loadData { [weak self] in
            
            self?.tableView.reloadData()
        }
    }
    
    private func showAlert(text: String){
        
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard var cell = viewModel.createCell(by: indexPath, tableView: tableView) as? CellProtocol else {
            
            return UITableViewCell()
        }
        
        let info = viewModel.getInfo(by: indexPath)
        cell.configure(with: info)
        cell.variantChosed  = { [weak self] text in
            self?.showAlert(text: text)
        }
        
        return cell as? UITableViewCell ?? UITableViewCell()
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        viewModel.cellHeight(by: indexPath)
    }
}
