//
//  FeedController.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/17.
//


import UIKit
import SnapKit
import SDWebImage

class FeedController: UIViewController {
    // MARK: - Properities
    
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    
    // MARK: - lifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()
        
    }
    
    // MARK: - API
    func fetchTweets() {
        TweetService.shared.fetchTweets { tweets in
            print(tweets)
        }
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
        navigationItem.titleView = imageView
    }
    
    func configureLeftBarButton() {
        guard let user = user else { return }
        
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .twitterBlue
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
        
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}




import SwiftUI

struct FeedControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = FeedController

    func makeUIViewController(context: Context) -> FeedController {
        return FeedController()
    }

    func updateUIViewController(_ uiViewController: FeedController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct FeedControllerPreview: PreviewProvider {
    static var previews: some View {
        FeedControllerRepresentable()
    }
}
