//
//  RouterModel.swift
//  NavgationDemo
//
//  Created by Tianc Lin on 2025/6/29.
//

import SwiftUI

enum NavPath:  Hashable {
    case home, user(Int), profile(Int), settings
    
    var name: String {
        switch self {
        case .home:
            return "Home"
        case .user(let id):
            return "User \(id)"
        case .profile(let id):
            return "Profile \(id)"
        case .settings:
            return "Settings"
        }
    }
        
}

@MainActor
final
class RouterModel: ObservableObject {
    var horizontalSize: UserInterfaceSizeClass? = nil
    @Published var currentPath: NavPath? = .home
    @Published var path: [NavPath] = []
    
    func backToRoot() {
        // Back to silderbar on compact size like iPhone
        if horizontalSize == .compact {
            currentPath = nil
            return
        }
        
        // Back to next root view (user view in this case)
        if case .user(_) = currentPath, let user =  UserModel.shared.users.first{
            currentPath = .user(user.id)
        }else{
            path = []
            currentPath = .home
            
        }
            
    }
}
    
