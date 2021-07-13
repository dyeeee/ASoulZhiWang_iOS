//
//  ASoulZhiWang_iOSApp.swift
//  ASoulZhiWang_iOS
//
//  Created by YES on 2021/7/13.
//

import SwiftUI

@main
struct ASoulZhiWang_iOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
