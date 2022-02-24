//
//  UserService.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/24.
//

import Foundation
import FirebaseAuth

struct UserService {
    static let shared = UserService()
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        DB.REF_UESERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            print(snapshot)
            guard let dic = snapshot.value as? [String : AnyObject] else { return }
            guard let username = dic["username"] as? String else {return}
            print(username)
            
            let user = User(uid: uid, dictionary: dic)
            
            print("DEBUG: Username is \(user.username)")
            print("DEBUG: Username is \(user.fullname)")
        }
    }
}
