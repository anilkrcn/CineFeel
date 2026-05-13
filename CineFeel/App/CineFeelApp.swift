//
//  CineFeelApp.swift
//  CineFeel
//
//  Created by Anıl Karacan on 7.05.2026.
//

import SwiftUI

@main
struct CineFeelApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}

struct MainTabView: View {

    var body: some View {

        TabView {

            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            SearchMovieView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}
