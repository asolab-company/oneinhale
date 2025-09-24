import SwiftUI

struct MenuView: View {
    var onStart: (_ seconds: Int) -> Void
    var onOpenSettings: () -> Void

    let times: [String] = [
        "00:30", "01:00", "01:30",
        "02:00", "02:30", "03:00",
        "03:30", "04:00", "04:30",
        "05:00", "07:00", "10:00",
    ]

    @State private var selected: String? = "02:30"

    private let cols = Array(
        repeating: GridItem(.flexible(), spacing: 16),
        count: 3
    )

    private func seconds(from mmss: String) -> Int {
        let parts = mmss.split(separator: ":")
        guard parts.count == 2,
            let minutes = Int(parts[0]),
            let seconds = Int(parts[1])
        else { return 0 }
        return minutes * 60 + seconds
    }

    var body: some View {
        ZStack {
            Color(hex: "#1F2842")
                .ignoresSafeArea()

            GeometryReader { geo in
                let horizontalPadding: CGFloat = 24
                let barWidth = geo.size.width - horizontalPadding * 4

                VStack(spacing: 20) {
                    Spacer()

                    Image("app_ic_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width - horizontalPadding * 8)

                    LazyVGrid(columns: cols, spacing: 16) {
                        ForEach(times, id: \.self) { t in
                            TimePill(
                                title: t,
                                isSelected: t == selected
                            ) {
                                selected = t
                            }
                        }
                    }

                    Button {
                        let pick = selected ?? times.first ?? "02:30"
                        let totalSeconds = seconds(from: pick)
                        print(
                            "Start pressed with:",
                            pick,
                            "->",
                            totalSeconds,
                            "sec"
                        )
                        onStart(totalSeconds)
                    } label: {
                        ZStack {
                            Text("Start")
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
                    .padding(.top)

                    Spacer()
                    Spacer()

                    HStack(spacing: 24) {
                        Spacer()

                        Button(action: {
                            onOpenSettings()
                        }) {
                            Text("Settings")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                        }
                        .background(
                            Capsule()
                                .fill(Color(hex: "#488DEB"))
                        )
                        Spacer()
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

struct TimePill: View {
    let title: String
    let isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white.opacity(0.9))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 7)
                .contentShape(Capsule())
        }
        .background(
            Capsule()
                .fill(Color.white.opacity(0.3))
        )
        .overlay(
            Capsule()
                .stroke(
                    Color.white.opacity(isSelected ? 1.0 : 0.0),
                    lineWidth: 3
                )
        )
        .shadow(radius: isSelected ? 6 : 0, y: isSelected ? 2 : 0)
        .animation(.easeInOut(duration: 0.12), value: isSelected)
    }
}
