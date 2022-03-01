//
//  TweetViewModel.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/28.
//

import Foundation
import UIKit


struct TweetViewModel {
    
    //MARK: - Properties
    
    //model 보유
    let tweet: Tweet
    var user: User
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
    
    //MARK: - 비즈니스 로직
    
    // 프로필 이미지 URL 뿌려주기
    var profileImageUrl: URL? {
        return tweet.user.profileImageUrl
    }
    
    // 몇 초 전, 며칠전, 몇 주전 데이터 뿌려주기
    var timeStamp: String {
        
        
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp!, to: now) ?? ""
    }
    
    
    // 사용자 정보 텍스트 뿌려주기
    var userInfoText: NSAttributedString {
        
        let title = NSMutableAttributedString(string: user.fullname,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        let info = NSAttributedString(string: " @\(user.username)・\(timeStamp)",
                                      attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                   .foregroundColor: UIColor.lightGray])
        title.append(info)
        return title
    }
}
