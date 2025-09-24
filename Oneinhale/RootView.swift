import SwiftUI

struct RootView: View {
    @EnvironmentObject var router: AppRouter

    @AppStorage("defaultTimerSeconds")
    private var defaultTimerSeconds: Int = 3 * 60

    var body: some View {
        ZStack {
            switch router.route {
            case .loading:
                LoadingView(onFinish: {
                    router.start()
                })
                .transition(.opacity)

            case .onboarding:
                OnboardingView(onContinue: {
                    router.completeOnboarding()
                })
                .transition(.opacity)

            case .menu:
                MenuView(
                    onStart: { secs in
                        router.openTimer(seconds: secs)
                    },
                    onOpenSettings: { router.openSettings() }
                )
                .transition(.opacity)

            case .timer(let seconds):
                TimerView(
                    initialSeconds: seconds,
                    onFinished: {
                        router.finishTimer(lastSeconds: seconds)
                    }
                )
                .transition(.opacity)

            case .finished(let last):
                FinishView(
                    onBackToMenu: { router.openMenu() },
                    onRepeat: { router.openTimer(seconds: last) }
                )
                .transition(.opacity)

            case .settings:
                SettingsView()
                    .onDisappear {

                        if case .settings = router.route {
                            router.openMenu()
                        }
                    }
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: router.route)
    }
}

#Preview { RootView() }
