import Foundation

struct CompletedWorkout: Identifiable, Codable {
    let id = UUID()
    let date: String
    let programName: String
}
