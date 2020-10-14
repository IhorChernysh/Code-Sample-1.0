//
//  StupselnReusableView.swift
//  p153-ios
//
//  Created by ihor-ios on 10.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import SnapKit
import Rswift

class StupselnReusableView: UICollectionReusableView {
 
    // MARK: - UI Properties
        
    private let stupselnImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = R.image.mainStupseln()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(text: "Trau Dich! Starte einen Flirt", font: UIFont.boldSystemFont(ofSize: 17), textAlignment: .center, textColor: .dark212121Color)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel(text: "Wähle einen Stupsler aus und klicke auf senden.", font: UIFont.boldSystemFont(ofSize: 17), textAlignment: .center, textColor: .dark212121Color)
        return label
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(section: StupselnSection) {
    }
}

// MARK: - Setup Layout

extension StupselnReusableView {
    private func setupUI() {
        addSubviews([stupselnImageView])
        
        stupselnImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(stupselnImageView.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
