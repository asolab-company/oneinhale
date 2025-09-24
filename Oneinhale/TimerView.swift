import Combine
import SwiftUI

struct TimerView: View {

    let initialSeconds: Int
    let circleScale: CGFloat
    var onFinished: () -> Void = {}

    @EnvironmentObject var router: AppRouter

    @State private var duration: Int
    @State private var remaining: Int
    @State private var isRunning = false

    private let ticker = Timer.publish(every: 1.0, on: .main, in: .common)
        .autoconnect()

    private static func parseMMSS(_ mmss: String) -> Int {
        let p = mmss.split(separator: ":")
        guard p.count == 2, let m = Int(p[0]), let s = Int(p[1]) else {
            return 0
        }
        return m * 60 + s
    }

    init(
        initialSeconds: Int = 3 * 60,
        circleScale: CGFloat = 0.9,
        onFinished: @escaping () -> Void = {}
    ) {
        self.initialSeconds = initialSeconds
        self.circleScale = circleScale
        self.onFinished = onFinished
        let clamped = max(initialSeconds, 0)
        _duration = State(initialValue: clamped)
        _remaining = State(initialValue: clamped)
    }

    init(
        mmss: String,
        circleScale: CGFloat = 0.9,
        onFinished: @escaping () -> Void = {}
    ) {
        self.init(
            initialSeconds: TimerView.parseMMSS(mmss),
            circleScale: circleScale,
            onFinished: onFinished
        )
    }
    var body: some View {
        ZStack {
            Color(hex: "#1F2842").ignoresSafeArea()

            GeometryReader { geo in
                let horizontalPadding: CGFloat = 24
                let minSide = min(geo.size.width, geo.size.height)
                let circleSize = minSide * circleScale

                VStack(spacing: 18) {
                    HStack {
                        Button {
                            router.openMenu()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white.opacity(0.9))
                        }

                        Spacer()
                        Spacer(minLength: 0)
                    }
                    .padding(.top, 8)

                    Spacer()
                    ZStack {

                        Circle()
                            .fill(Color.init(hex: "20477C"))
                            .frame(width: circleSize, height: circleSize)

                        Circle()
                            .stroke(
                                Color(hex: "#ffffff").opacity(0.27),
                                lineWidth: circleSize * 0.075
                            )
                            .frame(
                                width: circleSize * 0.86,
                                height: circleSize * 0.86
                            )

                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(
                                style: StrokeStyle(
                                    lineWidth: circleSize * 0.045,
                                    lineCap: .round
                                )
                            )
                            .fill(Color.white)
                            .rotationEffect(.degrees(-90))
                            .frame(
                                width: circleSize * 0.86,
                                height: circleSize * 0.86
                            )
                            .animation(.linear(duration: 0.05), value: progress)

                        Text(timeString(remaining))
                            .font(
                                .system(
                                    size: circleSize * 0.2,
                                    weight: .light
                                )
                            )
                            .foregroundColor(Color(hex: "#5AA3F6"))
                            .minimumScaleFactor(0.6)
                    }

                    HStack {
                        StepPill(title: "-10 sec") { add(seconds: -10) }
                        Spacer()
                        StepPill(title: "+30 sec") { add(seconds: +30) }
                    }

                    Spacer()
                    Spacer()

                    Button(action: toggle) {
                        ZStack {
                            if isRunning {
                                Image("app_btn_stop")
                                    .resizable()
                                    .renderingMode(.original)
                                    .scaledToFit()
                                    .frame(
                                        width: circleSize * 0.27,
                                        height: circleSize * 0.27
                                    )
                            } else {
                                Image("app_btn_play")
                                    .resizable()
                                    .renderingMode(.original)
                                    .scaledToFit()
                                    .frame(
                                        width: circleSize * 0.27,
                                        height: circleSize * 0.27
                                    )
                            }
                        }
                    }
                    .padding(.bottom)
                }
                .padding(.horizontal, horizontalPadding)
            }
        }
        .onReceive(ticker) { _ in
            guard isRunning, remaining > 0 else { return }
            remaining = max(remaining - 1, 0)
            finishNow()
        }
    }

    private var progress: CGFloat {
        guard duration > 0 else { return 0 }
        return 1 - CGFloat(remaining) / CGFloat(duration)
    }

    private func toggle() {
        if remaining == 0 {
            remaining = duration
        }
        isRunning.toggle()
    }

    private func finishNow() {
        guard remaining == 0 else { return }
        isRunning = false
        onFinished()
    }

    private func add(seconds: Int) {
        let newRemaining = max(0, min(remaining + seconds, 12 * 60))
        remaining = newRemaining
        duration = max(duration, remaining)
        withAnimation(.easeInOut(duration: 0.15)) {}
        finishNow()
    }

    private func timeString(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return String(format: "%02d:%02d", m, s)
    }
}

private struct StepPill: View {
    let title: String
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 18)
                .background(Capsule().fill(Color.white.opacity(0.3)))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TimerView()
}
