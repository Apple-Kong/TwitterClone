//
//  ProfileHeaderViewModel.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/03/13.
//

import Foundation


enum ProfileFilterOPtions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    
    var description: String {
        switch self {
        case.tweets: return "Tweets"
        case.replies: return "Tweets & Replies"
        case.likes: return "Likes"
        }
    }
}
