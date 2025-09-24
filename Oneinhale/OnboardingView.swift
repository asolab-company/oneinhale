import SwiftUI

struct OnboardingView: View {
    var onContinue: () -> Void = {}
    var body: some View {
        ZStack {
            Color(hex: "#1F2842")
                .ignoresSafeArea()

            GeometryReader { geo in
                let horizontalPadding: CGFloat = 24
                let barWidth = geo.size.width - horizontalPadding * 4

                VStack(spacing: 28) {

                    Image("app_ic_onbording")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width - horizontalPadding * 2)

                    VStack(spacing: 10) {

                        Text("What you get with the app")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold))
                            .italic().padding(.bottom)

                        VStack(alignment: .leading, spacing: 18) {
                            BulletRow("Find your inner calm.")
                            BulletRow("Boost your energy, anytime.")
                            BulletRow(
                                "Better sleep starts with better breathing."
                            )
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)

                        Button(action: { onContinue() }) {
                            ZStack {

                                Text("Continue")
                                    .font(.system(size: 20, weight: .bold))

                                HStack {
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 20, weight: .bold))
                                }
                                .padding(.horizontal)
                            }
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(GreenCTAStyle())
                        .padding(.bottom)
                        TermsFooter()
                            .padding(.bottom)

                    }

                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .top
                )
                .padding(.horizontal, horizontalPadding)
            }
        }

    }

}

private struct BulletRow: View {
    let text: String
    init(_ text: String) { self.text = text }

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .regular))
                .multilineTextAlignment(.leading)
            Spacer()
            ZStack {
                Circle()
                    .fill(Color(hex: "#488DEB"))
                    .frame(width: 20, height: 20)

                Image(systemName: "checkmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
            }
        }
    }
}

private struct TermsFooter: View {
    var body: some View {
        VStack(spacing: 2) {
            Text("By Proceeding You Accept")
                .foregroundColor(Color.init(hex: "8E8E8E"))
                .font(.footnote)

            HStack(spacing: 0) {
                Text("Our ")
                    .foregroundColor(Color.init(hex: "8E8E8E"))
                    .font(.footnote)

                Link("Terms Of Use", destination: AppLinks.termsOfUse)
                    .font(.footnote)
                    .foregroundColor(Color.init(hex: "488DEB"))
                    .underline()

                Text(" And ")
                    .foregroundColor(Color.init(hex: "8E8E8E"))
                    .font(.footnote)

                Link("Privacy Policy", destination: AppLinks.privacyPolicy)
                    .font(.footnote)
                    .foregroundColor(Color.init(hex: "488DEB"))
                    .underline()
            }
        }
        .frame(maxWidth: .infinity)
        .multilineTextAlignment(.center)
    }
}

private struct GreenCTAStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(hex: "#15B046"), Color(hex: "#15B046"),
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
            .foregroundColor(.white)
            .overlay(
                Capsule()
                    .stroke(
                        Color.white.opacity(
                            configuration.isPressed ? 0.25 : 0.12
                        ),
                        lineWidth: 1
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .shadow(radius: configuration.isPressed ? 2 : 6, y: 2)
    }
}

extension Text {

    func link(_ url: URL) -> some View {
        Link(destination: url) { self }
    }
}
