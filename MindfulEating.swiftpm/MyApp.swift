import SwiftUI
import SwiftData

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Sound.play(sound: "Otjanbird Pt I by Spher", type: "mp3", category: .playback,numberOfLoops: -1, isBackgroundMusic: true)
                }
        }
        .modelContainer(for: EatingSessionData.self)
    }
}
