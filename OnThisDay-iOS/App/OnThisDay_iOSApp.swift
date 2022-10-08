// Project: OnThisDay-iOS
//
//  
//

import SwiftUI

@main
struct OnThisDay_iOSApp: App {
    
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
