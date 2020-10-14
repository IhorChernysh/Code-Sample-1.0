//
//  StupselnCell.swift
//  p153-ios
//
//  Created by ihor-ios on 10.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import SnapKit
import SDWebImage

class StupselnCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    private let containerView: UIView = {
        let view = UIView(color: #colorLiteral(red: 0.8588235294, green: 0.8823529412, blue: 0.8901960784, alpha: 1))
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        return view
    }()
    
    private let stupselnImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = R.image.icoSun()
        imageView.tintColor = #colorLiteral(red: 0.09803921569, green: 0.337254902, blue: 0.4705882353, alpha: 1)
        return imageView
    }()
    
    private let stupselnTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Ich würde Dich gerne \nnäher kennenlernen!"
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.337254902, blue: 0.4705882353, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 17)//R.font.bloklettersViltstift(size: 12)
        return label
    }()
    
    private let selectedColor = #colorLiteral(red: 0.09803921569, green: 0.337254902, blue: 0.4705882353, alpha: 1)
    private let unselectedColor = #colorLiteral(red: 0.8588235294, green: 0.8823529412, blue: 0.8901960784, alpha: 1)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    
    func configure(stupseln: Stupslers) {
        stupselnImageView.sd_setImage(with: URL(string: stupseln.imageURLpng))
        stupselnTextLabel.text = stupseln.text
        
        if stupseln.isSelected {
            stupselnImageView.tintColor = .white
            containerView.backgroundColor = selectedColor
            stupselnTextLabel.textColor = .white
        } else {
            stupselnImageView.tintColor = selectedColor
            containerView.backgroundColor = unselectedColor
            stupselnTextLabel.textColor = selectedColor
        }
    }
}

// MARK: - Setup Layout

extension StupselnCell {
    private func setupUI() {
        backgroundColor = .clear
        
        setImageAndTextLabel()
    }
    
    private func setImageAndTextLabel() {
        addSubviews([containerView, stupselnImageView, stupselnTextLabel])
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stupselnImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(35)
        }
        
        stupselnTextLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(70)
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }
}
