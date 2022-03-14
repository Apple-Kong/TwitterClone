//
//  ProfileHeader.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/03/02.
//

import UIKit

protocol ProfileHeaderDelegate {
    func backButtonTap()
}

class ProfileHeader: UICollectionReusableView {
    // MARK: - Properties
    
    var user: User? {
        didSet { configure() }
    }
    
    var delegate: ProfileHeaderDelegate?
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .twitterBlue
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(42)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(30)
        }
        return view
    }()
    
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "baseline_arrow_back_white_24dp"), for: .normal)
        button.addTarget(self, action: #selector(handleDismissAll), for: .touchUpInside)
        return button
    }()
    
    
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.snp.makeConstraints { make in
            make.size.equalTo(80)
        }
        iv.backgroundColor = .twitterBlue
        iv.layer.cornerRadius = 80 / 2
        iv.contentMode  = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        
        
        return iv
    }()
    
    private lazy var editFollowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Loading", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(100)
        }
        button.layer.cornerRadius = 36 / 2
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        
        button.addTarget(self, action: #selector(handleEditFollowProfile), for: .touchUpInside)
        return button
    }()
    
    
    private let fullNameLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Full Name"
        return label
    }()
    
    private let userNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.text = "@userName"
        return label
    }()
    
    private let bioLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "This is a user bio that will span more than one line for test purposes"
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()

        
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()

        
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        return label
    }()
    

    
    private let filterBar = ProfileFilterView()
    
    private let underlineView: UIView = {
       let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        filterBar.delegate = self
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
    // MARK: - Selectors
    
    @objc func handleDismissAll() {
        delegate?.backButtonTap()
    }
    
    @objc func handleEditFollowProfile() {
        print("DEBUG: handle Edit Profile...")
    }
    
    @objc func handleFollowersTapped() {
        print("DEBUG: handle Followers Tap")
    }
    
    @objc func handleFollowingTapped() {
        print("DEBUG: handle Followers Tap")
    }
    
    // MARK: - Helpers
    func configure() {
        guard let user = user else { return }
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        fullNameLabel.text = user.fullname
        userNameLabel.text = user.username
        
        
        let viewModel = ProfileHeaderViewModel(user: user)
        editFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        followersLabel.attributedText = viewModel.followersString
        followingLabel.attributedText = viewModel.followingString
        
    }
    
    func configureUI() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(-24)
            make.leading.equalToSuperview().offset(10)
        }
        
        addSubview(editFollowButton)
        editFollowButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        
       
        
        let userDetailStack = UIStackView(arrangedSubviews: [fullNameLabel, userNameLabel, bioLabel])
        userDetailStack.axis = .vertical
        userDetailStack.distribution = .fillProportionally
        
        addSubview(userDetailStack)
        userDetailStack.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(100)
        }
        
        let followStack = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        followStack.axis = .horizontal
        followStack.distribution = .fillProportionally
        followStack.spacing = 8
        
        addSubview(followStack)
        followStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalTo(bioLabel.snp.bottom).offset(8)
        }
        
        
        addSubview(filterBar)
        filterBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalTo(frame.width / 3)
            make.height.equalTo(2)
            make.leading.equalToSuperview()
        }
    }
}


extension ProfileHeader: ProfileFitlerViewDelegate {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        
        
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? ProfileFilterCell else {
            return
        }
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
    }
}
