//
//  bonsaiApp.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.12.2021.
//

import SwiftUI

@main
struct bonsaiApp: App {

    @StateObject private var dataController = DataController.sharedInstance

    var body: some Scene {
        WindowGroup {
           BudgetDetails(mainContext: dataController.container.viewContext)
//            TabBar()
//                .environment(\.managedObjectContext, dataController.container.viewContext)
//                .environment(\.persistentContainer, dataController.container)
        }
    }
}
