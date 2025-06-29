//
//  RouterModel.swift
//  NavgationDemo
//
//  Created by Tianc Lin on 2025/6/29.
//

import SwiftUI

struct User: Identifiable {
    let id: Int
}

@Observable final
class UserModel{
    static let shared = UserModel()
    var users: [User] = []
    var userCount = 0
    
      func addUser() {
          userCount += 1
          let newUser = User(id: userCount)
          users.append(newUser)
      }
    
    func removeUser(_ userID:Int) {
        users.removeAll { $0.id == userID }
    }
}
    
