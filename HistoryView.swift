import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var workoutHistory: WorkoutHistory

    var body: some View {
        NavigationView {
            List(workoutHistory.history) { workout in
                HStack {
                    VStack(alignment: .leading) {
                        Text(workout.programName)
                            .font(.headline)
                        Text(workout.date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Workout History")
        }
    }
}
