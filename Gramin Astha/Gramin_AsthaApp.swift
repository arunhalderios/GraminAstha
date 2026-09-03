//
//  Gramin_AsthaApp.swift
//  Gramin Astha
//
//  Created by Debabrata Mandal on 13/08/26.
//

import SwiftUI

@main
struct Gramin_AsthaApp: App {
    
    
    let persistenceController =
        PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
