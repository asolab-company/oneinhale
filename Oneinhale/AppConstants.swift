import Foundation

enum AppLinks {

    static let appURL = URL(string: "https://apps.apple.com/app/id6752940198")!

    static let termsOfUse = URL(string: "https://docs.google.com/document/d/e/2PACX-1vTk_cdQgEqjTcGVk49yB6I5gfoe8tu-J27ryKdhTHhlsfFSiAhMt9SW5OT3yXCgALYVFbcrlHIdQgmc/pub")!
    static let privacyPolicy = URL(string: "https://docs.google.com/document/d/e/2PACX-1vTk_cdQgEqjTcGVk49yB6I5gfoe8tu-J27ryKdhTHhlsfFSiAhMt9SW5OT3yXCgALYVFbcrlHIdQgmc/pub")!

    static var shareMessage: String {
        """
        Try OneInhale — quick breathing sessions to calm down, boost energy, and sleep better. Download the app:
        \(appURL.absoluteString)
        """
    }

    static var shareItems: [Any] { [shareMessage, appURL] }
}
