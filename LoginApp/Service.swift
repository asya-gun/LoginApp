//
//  Service.swift
//  LoginApp
//
//  Created by Asya Checkanar on 25.02.2023.
//

import Foundation
import Firebase

class Service {
    
    func registerNewUser(email: String, password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { res, err in
            if err == nil {
                if let res = res {
                    res.user.sendEmailVerification()
                    self.saveUserData(uid: res.user.uid, email: email)
                    completion(true)
                }
                
            } else {
                let err = err as? NSError
                switch err?.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    completion(false)
                default:
                    completion(true)
                }
            }
        }
    }
    
    func logIn(email: String, password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { res, err in
            if err == nil {
                if let res = res {
                    if res.user.isEmailVerified {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
                
            } else {
                completion(false)
            }
        }
    }
    
    
    func saveUserData(uid: String, email: String) {
        let userData: [String: Any] = [
            "email" : email,
            "name" : "Asya",
            "avatar" : "mjgkcdiyi",
            "date" : Date(),
            "isVerified" : false
        ]
        
        Firestore.firestore().collection("users")
            .document(uid)
            .setData(userData)
    }
    
    func logOut() {
        try? Auth.auth().signOut()
        UserDefaults.standard.set(false, forKey: "isLogin")
        print("logged out")
    }
    
    func getAllUsers(completion: @escaping ([User]) -> ()) {
        let uid = Auth.auth().currentUser?.uid
        
        
        Firestore.firestore().collection("users")
            .addSnapshotListener { snap, err in
                if err == nil {
                    var users = [User]()
                    if let docs = snap?.documents {
                        for doc in docs {
//                            for user in users {
                            var user = User()
//                            let avatar = doc["avatar"]
                            user.name = doc["name"] as? String
                            user.email = doc["email"] as! String
                            user.avatar = doc["avatar"] as? String
                            users.append(user)
                                                            
//                            }
                            
                        }
                        completion(users)
                    }
                }
            }
    }
    
}
