//
//  Home.swift
//  Little Lemon
//
//  Created by Arslan Mushtaq on 3/4/23.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Label("Home", systemImage: "fork.knife")
                }
            
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .navigationBarBackButtonHidden(true)
        .toolbarColorScheme(.light, for: .tabBar)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
