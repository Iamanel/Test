//
//  AnelProject2_0App.swift
//  AnelProject2.0
//
//  Created by Sagynzhan Amangeldi on 17.05.2024.
//

import SwiftUI

@main
struct AnelProject2_0App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
