//
//  Constant.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/22.
//

import Firebase
import FirebaseDatabase
import FirebaseStorage

class DB {
    static let URL = "https://twitterclone-3af3c-default-rtdb.asia-southeast1.firebasedatabase.app"
    static let REF = Database.database(url: DB.URL).reference()
    static let REF_UESERS = DB.REF.child("users")
    static let REF_TWEETS = DB.REF.child("tweets")
}

class STORAGE {
    static let REF = Storage.storage(url: "gs://twitterclone-3af3c.appspot.com/").reference()
    static let PROFILE_IMAGES = STORAGE.REF.child("profile_images")
}
