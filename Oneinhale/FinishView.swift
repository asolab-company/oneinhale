import SwiftUI

struct FinishView: View {
    var onBackToMenu: () -> Void
    var onRepeat: () -> Void

    var body: some View {
        ZStack {
            Color(hex: "#1F2842")
                .ignoresSafeArea()

            GeometryReader { geo in
                let horizontalPadding: CGFloat = 24
                let barWidth = geo.size.width - horizontalPadding * 4

                VStack(spacing: 20) {
                    Spacer()

                    Image("app_ic_onbording")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width - horizontalPadding * 2)

                    (Text("GREAT")
                        .foregroundColor(.white)
                        + Text(" JOB")
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color(hex: "#488DEB"),
                                    Color(hex: "#488DEB"),
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        ))
                        .font(.system(size: 52, weight: .heavy))
                        .italic()
                        .shadow(color: .black.opacity(0.25), radius: 2, y: 1)

                    Spacer()
                    Spacer()
                    HStack(spacing: 24) {

                        Button(action: {
                            onBackToMenu()
                        }) {
                            Text("Menu")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                        }
                        .background(
                            Capsule()
                                .fill(Color(hex: "#488DEB"))
                        )

                        Button(action: {
                            onRepeat()
                        }) {
                            ZStack {

                                Text("Try Again")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)

                                HStack {
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                .padding(.trailing, 20)
                            }
                            .padding(.vertical, 16)
                        }
                        .background(
                            Capsule()
                                .fill(Color(hex: "#15B046"))
                        )

                    }
                    .padding(.bottom)

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
struct GradientText: View {
    let text: String
    let gradient: LinearGradient
    init(_ text: String, gradient: LinearGradient) {
        self.text = text
        self.gradient = gradient
    }
    var body: some View {
        gradient.mask(
            Text(text)
                .baselineOffset(0)
        )
    }
}
