//
//  TweetService.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/24.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase


struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping (Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retweets" : 0,
                      "caption": caption] as [String: Any]
        DB.REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
        
    }
    
    
    func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        //.childAdded 란? 데이터베이스의 하위 구조에 리스너를 추가. 데이터가 업데이트 되면 자동으로 추가적인 데이터를 가져옴.
        DB.REF_TWEETS.observe(.childAdded) { snapShot in
            
            guard let dictionary = snapShot.value as? [String : Any] else {return}
            let tweetID = snapShot.key //snapshot 의 ket 가 트윗의 id
            let tweet = Tweet(tweetID: tweetID, dictionary: dictionary)
            tweets.append(tweet)
            completion(tweets)
        }
    }
}
