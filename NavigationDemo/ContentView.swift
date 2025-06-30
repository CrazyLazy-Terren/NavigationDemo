//
//  ContentView.swift
//
//  Created by Tianc Lin on 2025/6/23.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.horizontalSizeClass) var horizontalSize: UserInterfaceSizeClass?
  @StateObject private var routerModel = RouterModel()
  @State private var userModel = UserModel.shared

  var body: some View {
    NavigationSplitView {
      // Sidebar column
      List(selection: $routerModel.currentPath) {
        NavigationLink(value: NavPath.home) {
          Label("Home", systemImage: "house")
        }
        Section("User") {
          ForEach(userModel.users) { user in
            NavigationLink(value: NavPath.user(user.id)) {
              Label("User \(user.id)", systemImage: "person")
            }
          }
        }
        Section {
          NavigationLink(value: NavPath.settings) {
            Label("Settings", systemImage: "gear")
          }

        }

      }
      .navigationTitle("Sidebar")
      #if os(macOS)
        .frame(minWidth: 200)
      #endif
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button {
            userModel.addUser()

          } label: {
            Label("Add User", systemImage: "plus")
          }

        }

      }
    } detail: {
      // Detail column with NavigationStack
      NavigationStack(path: $routerModel.path) {
        DetailView(item: routerModel.currentPath ?? .home)
          .environmentObject(routerModel)
          .navigationDestination(for: NavPath.self) { path in
            DetailView(item: path)
              .environmentObject(routerModel)
          }
      }

    }.onChange(of: horizontalSize, initial: true) {
      routerModel.horizontalSize = horizontalSize
    }
  }
}

// Detail view to display in the second column
struct DetailView: View {
  let item: NavPath

  var body: some View {
    Group {
      switch item {
      case .home:
        VStack {
          Text("Home View")
            .font(.largeTitle.bold())
          NavigationLink("Setting", value: NavPath.settings)
        }
      case .user(let userID):
        VStack {
          Text("User View for User \(userID)")
          NavigationLink("Profile", value: NavPath.profile(userID))
        }

      case .profile(let userID):
        ProfileView(userID: userID)
      case .settings:
        Text("Settings View")
      }
    }
    .navigationTitle(item.name)
  }
}

struct ProfileView: View {
  @EnvironmentObject var routerModel: RouterModel
  let userID: Int
  var body: some View {
    VStack {
      Text("Profile View for User \(userID)")
      Button(role: .destructive) {
        UserModel.shared.removeUser(userID)
        routerModel.backToRoot()
      } label: {
        Label("Delete User \(userID)", systemImage: "trash")
      }
    }
  }

}

#Preview {
  ContentView()
}
