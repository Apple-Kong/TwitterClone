//
//  UploadTweetController.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/24.
//

import Foundation
import UIKit
import SDWebImage

class UploadTweetController: UIViewController {
    
    // MARK: - Properties
    
    private let user: User
    
    //lazy 를 써야 addtarget 이 제대로 작동함.
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        
        return button
    }()
    
    
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
    // MARK: - LifeCycles
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    // MARK: - Selectors
    @objc func handleUploadTweet() {
        print("DEBUG: upload tweet....")
    }
    @objc func handeCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        
        view.addSubview(profileImageView)
        //같은 url 에대한 이미지를 캐싱해서 > 같은 url 에 대한 이미지 요청시 캐싱된 이미지를 불러와 설정하게 됨.
        //추가적인 API 호출이 필요없음.
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
        }
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handeCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
}
