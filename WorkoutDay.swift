import Foundation

struct WorkoutDay: Codable, Identifiable {
    let id = UUID()
    let day: String
    let title: String
    let exercises: [WorkoutExercise]
}

struct WorkoutExercise: Codable, Identifiable {
    let id = UUID()
    let exerciseName: String
    let sets: Int
    let reps: String
    let restTime: Int
    let tempo: String
}


