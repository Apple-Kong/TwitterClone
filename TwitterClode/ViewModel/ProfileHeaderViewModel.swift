//
//  ProfileHeaderViewModel.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/03/13.
//

import Foundation
import UIKit
import FirebaseAuth


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


struct ProfileHeaderViewModel {
    
    
    private let user: User
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: 2, text: "following")
    }
    
    var followersString: NSAttributedString? {
        return attributedText(withValue: 0, text: "followers")
    }
    
    var actionButtonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return "Follow"
        }
    }


    
    init(user: User) {
        self.user = user
    }
    
    private func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: " \(text)", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),
                                                                                   NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        
        return attributedTitle
    }
}


