//
//  User.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/24.
//

import Foundation


struct User {
    let uid: String
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    
    
    
    //struct 로 파싱하는 메서드 직접 작성해야함.
    //그리고 이런 메서드는 Model 로 빼야함.
    init(uid: String, dictionary: [String : AnyObject]) {
        
        self.uid = uid
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        
    }
}
