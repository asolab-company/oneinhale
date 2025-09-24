import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var router: AppRouter
    @Environment(\.openURL) private var openURL
    @State private var showShare = false

    var body: some View {
        ZStack {
            Color(hex: "#1F2842").ignoresSafeArea()

            GeometryReader { geo in
                let horizontalPadding: CGFloat = 24

                VStack(alignment: .leading, spacing: 18) {
                    Button {
                        router.openMenu()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(.top, 8)
                    .padding(.bottom)

                    SettingsRow(
                        icon: "app_ic_share",
                        title: "Share app",
                        action: { showShare = true }
                    )

                    SettingsRow(
                        icon: "app_ic_terms",
                        title: "Terms and Conditions",
                        action: { openURL(AppLinks.termsOfUse) }
                    )

                    SettingsRow(
                        icon: "app_ic_privacy",
                        title: "Privacy",
                        action: { openURL(AppLinks.privacyPolicy) }
                    )

                    Spacer()
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .top
                )
                .padding(.horizontal, horizontalPadding)
            }
        }
        .sheet(isPresented: $showShare) {
            ShareSheet(items: AppLinks.shareItems)
        }
    }
}

private struct SettingsRow: View {
    let icon: String
    let title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)

                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(hex: "#488DEB"))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                Capsule().fill(Color(hex: "20477C").opacity(0.8))
            )
        }
        .buttonStyle(.plain)
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
    }
    func updateUIViewController(
        _ vc: UIActivityViewController,
        context: Context
    ) {}
}

#Preview {
    SettingsView()
}
