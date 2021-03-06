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
    
    private let variantOneLabel = UILabel()
    private let variantTwoLabel = UILabel()
    private let variantThreeLabel = UILabel()
    private let buttonOne = UIButton()
    private let buttonTwo = UIButton()
    private let buttonThree = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with info: InfoData) {
        
        self.infoData = info
        
        let variant1 = info.data?.variants?[0]
        let variant2 = info.data?.variants?[1]
        let variant3 = info.data?.variants?[2]
        
        guard
            let text1 = variant1?.text, let textId1 = variant1?.id,
            let text2 = variant2?.text, let textId2 = variant2?.id,
            let text3 = variant3?.text, let textId3 = variant3?.id
        else { return }
        
        variantOneLabel.text = "\(text1). ID: \(textId1)"
        variantTwoLabel.text = "\(text2). ID: \(textId2)"
        variantThreeLabel.text = "\(text3). ID: \(textId3)"
    }
    
    @objc private func variantOnePressed() {
        
        guard let id =  infoData.data?.variants?[0].id else { return }
        let text = "Action triggered by selector. ID is: \(id)"
        variantChosed?(text)
    }
    
    @objc private func variantTwoPressed() {
        
        guard let id =  infoData.data?.variants?[1].id else { return }
        let text = "Action triggered by selector. ID is: \(id)"
        variantChosed?(text)
    }
    
    @objc private func variantThreePressed() {
        
        guard let id =  infoData.data?.variants?[2].id else { return }
        let text = "Action triggered by selector. ID is: \(id)"
        variantChosed?(text)
    }
    
    private func setupUI() {
        
        selectionStyle = .none
        
        addSubview(variantOneLabel)
        variantOneLabel.textAlignment = .center
        variantOneLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        
        contentView.addSubview(buttonOne)
        buttonOne.snp.makeConstraints { (make) in
            make.top.equalTo(variantOneLabel.snp.top)
            make.bottom.equalTo(variantOneLabel.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        buttonOne.addTarget(self, action: #selector(variantOnePressed), for: .touchUpInside)
        
        addSubview(variantTwoLabel)
        variantTwoLabel.textAlignment = .center
        variantTwoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(variantOneLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        
        contentView.addSubview(buttonTwo)
        buttonTwo.snp.makeConstraints { (make) in
            make.top.equalTo(variantTwoLabel.snp.top)
            make.bottom.equalTo(variantTwoLabel.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        buttonTwo.addTarget(self, action: #selector(variantTwoPressed), for: .touchUpInside)
        
        addSubview(variantThreeLabel)
        variantThreeLabel.textAlignment = .center
        variantThreeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(variantTwoLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        
        contentView.addSubview(buttonThree)
        buttonThree.snp.makeConstraints { (make) in
            make.top.equalTo(variantThreeLabel.snp.top)
            make.bottom.equalTo(variantThreeLabel.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        buttonThree.addTarget(self, action: #selector(variantThreePressed), for: .touchUpInside)
    }
}
