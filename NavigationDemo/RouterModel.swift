//
//  RouterModel.swift
//
//  Created by Tianc Lin on 2025/6/29.
//

import SwiftUI

enum NavPath: Hashable {
  case home
  case user(Int)
  case profile(Int)
  case settings

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
  class RouterModel: ObservableObject
{
  var horizontalSize: UserInterfaceSizeClass? = nil
  @Published var currentPath: NavPath? = .home
  @Published var paths: [NavPath] = []

  func backToRoot() {
    // Back to silderbar on compact size like iPhone
    if horizontalSize == .compact {
      currentPath = nil
      return
    }

    // Back to next root view (user view in this case)
    if case .user(_) = currentPath, let user = UserModel.shared.users.first {
      currentPath = .user(user.id)
    } else {
      paths = []
      currentPath = .home

    }

  }
}
