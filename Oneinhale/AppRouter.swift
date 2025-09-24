import SwiftUI

final class AppRouter: ObservableObject {
    enum Route: Equatable {
        case loading
        case onboarding
        case menu
        case timer(seconds: Int)
        case finished(lastSeconds: Int)
        case settings
    }

    @Published var route: Route = .loading

    @AppStorage("didSeeOnboarding") private var didSeeOnboarding: Bool = false

    func start() {

        route = didSeeOnboarding ? .menu : .onboarding
    }

    func completeOnboarding() {
        didSeeOnboarding = true
        route = .menu
    }

    func openMenu() { route = .menu }
    func openSettings() { route = .settings }
    func openTimer(seconds: Int) { route = .timer(seconds: seconds) }

    func finishTimer(lastSeconds: Int) {
        route = .finished(lastSeconds: lastSeconds)
    }
}
