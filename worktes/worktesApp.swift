import SwiftUI

@main
struct WorkoutProApp: App {
    @StateObject private var workoutHistory = WorkoutHistory() // Create the object

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(workoutHistory) // Pass it to all child views
        }
    }
}
