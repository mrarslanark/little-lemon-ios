//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by Arslan Mushtaq on 3/1/23.
//

import SwiftUI

@main
struct Little_LemonApp: App {
    
    let persistence = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Registration().environment(\.managedObjectContext, persistence.container.viewContext)
        }
    }
}
