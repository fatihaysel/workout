import Foundation

struct Exercise: Codable, Identifiable {
    let id = UUID() // Automatically generates a unique ID for each exercise
    let exerciseName: String
    let targetMuscleGroup: String
    let videoUrl: String
}


func loadExercises() -> [Exercise] {
    guard let url = Bundle.main.url(forResource: "exercises", withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let exercises = try? JSONDecoder().decode([Exercise].self, from: data) else {
        return [] // Return an empty array if JSON cannot be loaded or parsed
    }
    return exercises
}
