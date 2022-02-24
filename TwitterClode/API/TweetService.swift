//
//  TweetService.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/24.
//

import Foundation
import FirebaseAuth


struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let values = ["uid": uid, "timestamp": ]
    }
}
