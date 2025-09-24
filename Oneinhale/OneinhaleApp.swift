import SwiftUI

@main
struct OneinhaleApp: App {
    @StateObject private var router = AppRouter()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
        }
    }
}
