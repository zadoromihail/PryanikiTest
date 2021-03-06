//
//  CellWithImage.swift
//  PryanikyTest
//
//  Created by Михаил Задорожный on 05.03.2021.
//

import UIKit
import SnapKit
import Kingfisher

class CellWithImage: UITableViewCell, CellProtocol {
    
    var infoData = InfoData()
    var variantChosed: ((String) -> ())?
    let infoTextLabel = UILabel()
    let infoImageView = UIImageView()
    let button = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with info: InfoData) {
        
        self.infoData = info
        infoTextLabel.text = info.data?.text
        
        guard let stringUrl = info.data?.url, let url = URL(string: stringUrl) else { return}
        infoImageView.kf.setImage(with: url)
    }
    
    private func setupUI() {
        
        addSubview(infoTextLabel)
        infoTextLabel.textAlignment = .center
        infoTextLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        
        addSubview(infoImageView)
        infoImageView.contentMode = .scaleAspectFit
        infoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(infoTextLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(200)
        }
        
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc private func buttonPressed() {
    
        guard let name =  infoData.name else { return }
        let text = "Action triggered by: \(name)"
        variantChosed?(text)
    }
}
