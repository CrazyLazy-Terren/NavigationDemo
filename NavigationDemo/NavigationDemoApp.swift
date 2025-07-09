//
//
//  Created by Tianc Lin on 2025/6/23.
//

import SwiftUI

@main
struct NavigationDemoApp: App {
    @AppStorage("theme") private var theme: Theme = .system
    @AppStorage("tintColor") private var tintColor: TintColor = .blue
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(theme.colorScheme)
                .tint(tintColor.color)
        }
    }
}
