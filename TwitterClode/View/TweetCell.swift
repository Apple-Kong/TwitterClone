//
//  TweetCell.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/27.
//

import UIKit

class TweetCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    
    //트윗 데이터가 건네와 지면 셀에 데이터를 연결해주는 함수 호출
    var tweet: Tweet? {
        didSet { configure() }
    }
    
    private let profileImageView : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .twitterBlue
        iv.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        iv.layer.cornerRadius = 48 / 2
        return iv
    }()
    
    private let captionLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "Some Caption"
        return label
    }()
    
    let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .darkGray
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .darkGray
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        button.addTarget(self, action: #selector(retweetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .darkGray
        button.setImage(UIImage(named: "like"), for: .normal)
        button.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .darkGray

        button.setImage(UIImage(named: "share"), for: .normal)
        button.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let infoLabel = UILabel()

    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Selectors
    @objc func commentButtonTapped() {
        
    }
    
    @objc func retweetButtonTapped() {
        
    }
    
    @objc func likeButtonTapped() {
        
    }
    
    @objc func shareButtonTapped() {
        
    }
    
    // MARK: - Helpers
    func configure() {
        guard let tweet = tweet else { return }
        
        captionLabel.text = tweet.caption
        profileImageView.sd_setImage(with: tweet.user.profileImageUrl, completed: nil)
        infoLabel.text = tweet.user.username + tweet.user.fullname
    }
    
    func configureUI() {
        
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
        }
        
        
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.top.equalTo(profileImageView)
            make.trailing.equalToSuperview()
            
        }
        
        infoLabel.text = "Spider Man @Spidy"
        infoLabel.font = .systemFont(ofSize: 14)
        
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        actionStack.axis = .horizontal
        actionStack.distribution = .fillEqually
        actionStack.spacing = 72
        addSubview(actionStack)
        actionStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)

        }
    }
}
