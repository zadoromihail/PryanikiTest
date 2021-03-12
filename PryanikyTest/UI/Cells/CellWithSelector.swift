//
//  CellWithSelector.swift
//  PryanikyTest
//
//  Created by Михаил Задорожный on 05.03.2021.
//

import UIKit

class CellWithSelector: UITableViewCell, CellProtocol {
    
    var infoData = InfoData()
    var variantChosed: ((String) -> ())?
    
    private let variantLabel = UILabel()
    private let button = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with info: InfoData) {
        
        self.infoData = info
        
        let variant = info.data?.variants?.filter {$0.id == info.data?.selectedId}.first
        
        guard let text = variant?.text, let id = variant?.id else { return }
        
        variantLabel.text = "\(text). ID: \(id)"
    }
    
    @objc private func variantPressed() {
        
        guard let id =  infoData.data?.variants?[0].id else { return }
        let text = "Action triggered by selector. ID is: \(id)"
        variantChosed?(text)
    }
    
    private func setupUI() {
        
        selectionStyle = .none
        
        addSubview(variantLabel)
        variantLabel.textAlignment = .center
        variantLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalTo(variantLabel.snp.top)
            make.bottom.equalTo(variantLabel.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        button.addTarget(self, action: #selector(variantPressed), for: .touchUpInside)
    }
}
