import UIKit
import Flutter
import AVFoundation
import Firebase
import GoogleSignIn

@main
@objc class AppDelegate: FlutterAppDelegate {

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // Configure audio session for playback
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set AVAudioSession category: \(error)")
        }

        // Configure Firebase
        FirebaseApp.configure()
        GeneratedPluginRegistrant.register(with: self)

        // Restore previous Google Sign-In (for debugging)
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                print("Restore previous sign-in failed: \(error)")
            } else if let user = user {
                print("User restored: \(user.profile?.name ?? "No Name")")
            } else {
                print("No previous user found")
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // Handle URL callbacks for Google Sign-In
    @available(iOS 9.0, *)
    override func application(_ app: UIApplication, open url: URL,
                              options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
