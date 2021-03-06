//
//  TextBlockCell.swift
//  PryanikyTest
//
//  Created by Михаил Задорожный on 05.03.2021.
//

import UIKit
import SnapKit

class TextBlockCell: UITableViewCell, CellProtocol {
    
    let button = UIButton()
    var infoData = InfoData()
    var variantChosed: ((String) -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with info: InfoData) {
        self.infoData = info
        textLabel?.text = info.data?.text
    }
    
    private func setupUI() {
  
        textLabel?.textAlignment = .center
        
        contentView.addSubview(button)
        
        button.snp.makeConstraints { make in
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
