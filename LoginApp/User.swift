//
//  User.swift
//  LoginApp
//
//  Created by Asya Checkanar on 27.02.2023.
//

import Foundation
import FirebaseFirestore

struct User: Decodable {
    var email: String?
    var name: String?
    var avatar: String?
}
