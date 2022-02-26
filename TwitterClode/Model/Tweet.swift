//
//  Tweet.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/26.
//

import Foundation


struct Tweet {
    //indentifier
    let uid: String
    let tweetID: String
    //meta data
    var timestamp: Date?
    let retweetCount: Int
    let likes: Int
    
    //body
    let caption: String



    
    
    init(tweetID: String, dictionary: [String : Any]) {
        
        self.uid = dictionary["uid"] as? String ?? ""
        self.tweetID = tweetID
        


        self.retweetCount = dictionary["retweets"] as? Int ?? 0
        self.likes = dictionary["likes"] as? Int ?? 0
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
        
        self.caption = dictionary["caption"] as? String ?? ""
    }
}
