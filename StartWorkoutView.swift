import SwiftUI

struct StartWorkoutView: View {
    @State private var isWorkoutInProgress = false // Tracks if a workout is in progress
    @State private var selectedWorkoutDay: WorkoutDay? = nil // Holds the selected workout day

    let workoutPlan: [WorkoutDay] = loadWorkoutPlan()

    var body: some View {
        NavigationView {
            VStack {
                if isWorkoutInProgress, let workoutDay = selectedWorkoutDay {
                    // Show the WorkoutTrackerView
                    WorkoutTrackerView(
                        isWorkoutComplete: $isWorkoutInProgress,
                        day: workoutDay
                    )
                    .onDisappear {
                        // Reset the selected workout day after the tracker closes
                        if !isWorkoutInProgress {
                            selectedWorkoutDay = nil
                        }
                    }
                } else {
                    // Show available workout days
                    List(workoutPlan) { day in
                        Button(action: {
                            selectedWorkoutDay = day
                            isWorkoutInProgress = true // Start the tracker
                        }) {
                            VStack(alignment: .leading) {
                                Text(day.day)
                                    .font(.headline)
                                Text(day.title)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Start Workout")
        }
    }
}
