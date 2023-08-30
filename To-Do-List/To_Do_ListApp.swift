//
//  To_Do_ListApp.swift
//  To-Do-List
//
//  Created by Teboho Mohale on 2023/02/27.
//

import SwiftUI
import CoreData

@main
struct To_Do_ListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            
            let context = persistenceController.container.viewContext
            let dateHolder = DateHolder(context)
            
            
            SplashScreenView()
            
            //TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .environmentObject(dateHolder)
        }
    }
}
