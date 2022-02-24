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
}
