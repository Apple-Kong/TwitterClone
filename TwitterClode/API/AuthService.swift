//
//  AuthService.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/23.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
    let userName: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: AuthCredentials, completion: @escaping (Error?, DatabaseReference) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let fullName = credentials.fullName
        let userName = credentials.userName
        let profileImage = credentials.profileImage
        
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE.PROFILE_IMAGES.child(filename)
        
        
        storageRef.putData(imageData, metadata: nil) { meta, error in
            storageRef.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Error is \(error.localizedDescription) ")
                        return
                    } else {
                        
                        guard let uid = result?.user.uid else { return }
                        let values = ["email" : email, "username": userName, "fullname": fullName, "profileImageUrl" : profileImageUrl]
                        
                        //url 을 따로 따서 적어 놓을 것.
                        DB.REF_UESERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                    }
                }
            }
        }
    }
}
