import Foundation

struct Exercise: Codable, Identifiable {
    let id = UUID() // Automatically generates a unique ID for each exercise
    let exerciseName: String
    let targetMuscleGroup: String
    let videoUrl: String
}
