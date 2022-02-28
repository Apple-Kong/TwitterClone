//
//  TweetCell.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/27.
//

import UIKit

protocol TweetCellDelegate: class {
    func handleProfileImageTapped(_ cell: TweetCell)
}

class TweetCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    
    //트윗 데이터가 건네와 지면 셀에 데이터를 연결해주는 함수 호출
    var tweet: Tweet? {
        didSet { configure() }
    }
    
    //retain cycle 문제 떄문에 weak 사용해야함.
    // FeedController 가 TweetCell 을 소유
    // 하지만 TweetCell 이 FeedController 를 참조하게 된다면??
    // 참조 루프문제가 생김 이렇게 되면 서로가 서로를 참조하기 때문에 메모리 관리문제가 발생 메모리 상에서 지워지지 않고 낭비됨
    weak var delegate: TweetCellDelegate?
    
    //lazy var 로 선언해주어야 selector 가 제대로 작동함.
    private lazy var profileImageView : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .twitterBlue
        iv.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        iv.layer.cornerRadius = 48 / 2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
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
    @objc func handleProfileImageTapped() {
        self.delegate?.handleProfileImageTapped(self)
    }
    
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
        
        
        //뷰 모델 소유
        let viewModel = TweetViewModel(tweet: tweet)
        
        captionLabel.text = tweet.caption
        profileImageView.sd_setImage(with: viewModel.profileImageUrl, completed: nil)
        infoLabel.attributedText = viewModel.userInfoText
        
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
