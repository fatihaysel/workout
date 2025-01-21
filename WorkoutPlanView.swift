import SwiftUI

struct WorkoutPlanView: View {
    let workoutPlan: [WorkoutDay] = loadWorkoutPlan()

    var body: some View {
        NavigationView {
            List(workoutPlan) { day in
                Section(header: Text(day.day + ": " + day.title)) {
                    ForEach(day.exercises) { exercise in
                        VStack(alignment: .leading) {
                            Text(exercise.exerciseName)
                                .font(.headline)
                            Text("Sets: \(exercise.sets) | Reps: \(exercise.reps) | Tempo: \(exercise.tempo)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Workout Plan")
        }
    }
}

// Helper function to load the JSON data
func loadWorkoutPlan2() -> [WorkoutDay] {
    guard let url = Bundle.main.url(forResource: "workoutPlan", withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let plan = try? JSONDecoder().decode([WorkoutDay].self, from: data) else {
        return []
    }
    return plan
}

func loadWorkoutPlan() -> [WorkoutDay] {
    guard let url = Bundle.main.url(forResource: "workoutPlan", withExtension: "json") else {
        print("JSON file not found.")
        return []
    }
    
    do {
        let data = try Data(contentsOf: url)
        let plan = try JSONDecoder().decode([WorkoutDay].self, from: data)
        return plan
    } catch {
        print("Error decoding JSON: \(error)")
        return []
    }
}
