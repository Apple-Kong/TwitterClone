//
//  Constant.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/22.
//

import Foundation
import FirebaseDatabase


let FIREBASE_DATABASE_URL = "https://twitterclone-3af3c-default-rtdb.asia-southeast1.firebasedatabase.app"
let DB_REF = Database.database(url: FIREBASE_DATABASE_URL).reference()
let DB_REF_UESERS = DB_REF.child("users").child(uid)
