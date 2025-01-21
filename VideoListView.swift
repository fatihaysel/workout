import SwiftUI

struct VideoListView: View {
    let exercises: [Exercise] = loadExercises()

    var body: some View {
        NavigationView {
            List(exercises) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.exerciseName)
                        .font(.headline)
                    Text(exercise.targetMuscleGroup)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .onTapGesture {
                    if let url = URL(string: exercise.videoUrl) {
                        UIApplication.shared.open(url) // Open the video in Safari
                    }
                }
            }
            .navigationTitle("Videos")
        }
    }
}

// Helper function to load the JSON data
func loadExercises() -> [Exercise] {
    guard let url = Bundle.main.url(forResource: "exercises", withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let exercises = try? JSONDecoder().decode([Exercise].self, from: data) else {
        return []
    }
    return exercises
}
