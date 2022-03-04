//
//  ProfileFilterCell.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/03/02.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        label.text = "wow"
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            self.titleLabel.font = self.isSelected ? .boldSystemFont(ofSize: 16) : .systemFont(ofSize: 14)
            self.titleLabel.textColor = self.isSelected ? .twitterBlue : .lightGray
        }
    }
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("inti(coder:) has not been implemented")
    }
    // MARK: - Selectors
    // MARK: - Helpers
}
