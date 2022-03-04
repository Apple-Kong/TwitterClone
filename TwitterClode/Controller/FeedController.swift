//
//  FeedController.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/17.
//


import UIKit
import SnapKit
import SDWebImage

private let reuseIdentifier = "TweetCell"


//UICollectionViewController 사용
class FeedController: UICollectionViewController {
    // MARK: - Properities
    
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    private var tweets = [Tweet]() {
        
        //트윗이 수정 될 때마다 컬렉션뷰를 리로드해주어야함
        //collectionView 리로드 = delegate datasource 메서드 실행.
        didSet {
            collectionView.reloadData()
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
            self.tweets = tweets
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
        
        
        //컬렉션 뷰
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: "TweetCell")
        collectionView.backgroundColor  = .white
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


// MARK: - UICollectionViewDelegate/DataSource
//reloadData() 호출시 아래 메서드 재 호출
extension FeedController  {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
        return cell
    }
}
//MARK: - TweetCellDelegate
extension FeedController: TweetCellDelegate {
    func handleProfileImageTapped(_ cell: TweetCell) {
        let vc = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
//컬렉션 뷰의 아이템 사이즈 , 아이템간 스페이싱 조절,
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        //다이나믹하게 셀 사이즈를 조절해야함.
        return CGSize(width: view.frame.width, height: 120)
        
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
