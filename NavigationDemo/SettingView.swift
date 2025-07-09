//
//  SettingView.swift
//  NavigationDemo
//
//  Created by Tianc Lin on 2025/7/9.
//

import SwiftUI

enum Theme:String, CaseIterable {
    case light
    case dark
    case system
    var colorScheme: ColorScheme? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
}

enum TintColor: String,CaseIterable {
    case blue, green, red, yellow, purple, pink, orange, brown, gray
    
    var color:Color {
        switch self {
        case .blue:
            return Color.blue
        case .green:
            return Color.green
        case .red:
            return Color.red
        case .yellow:
            return Color.yellow
        case .purple:
            return Color.purple
        case .pink:
            return Color.pink
        case .orange:
            return Color.orange
        case .brown:
            return Color.brown
        case .gray:
            return Color.gray
        }
    }
}


struct SettingView: View {
    @AppStorage("theme") private var theme: Theme = .system
    @AppStorage("tintColor") private var tintColor: TintColor = .blue
    var body: some View {
        Form{
            Picker("Theme", selection: $theme) {
                ForEach(Theme.allCases, id: \.self) { theme in
                    Text(theme.rawValue.capitalized).tag(theme)
                }
            }
            Picker("Tint Color", selection: $tintColor) {
                ForEach(TintColor.allCases, id: \.self) { color in
                    Text(color.rawValue.capitalized).tag(color)
                }
            }
        }.tint(tintColor.color)
    }
}

#Preview {
    SettingView()
}
