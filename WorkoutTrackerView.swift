import SwiftUI

struct WorkoutTrackerView: View {
    @EnvironmentObject var workoutHistory: WorkoutHistory
    @Binding var isWorkoutComplete: Bool // Binding to notify parent view
    let day: WorkoutDay

    @State private var currentExerciseIndex = 0
    @State private var currentSet = 1
    @State private var restTimeRemaining = 0
    @State private var isResting = false
    @State private var weightInput = ""
    @State private var effort = "Medium"

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }

    var body: some View {
        VStack {
            if currentExerciseIndex < day.exercises.count - 1{
                
                currentExerciseView
            } else {
                workoutCompleteView
            }
        }
        .padding()
        .onAppear {
            resetTracker() // Reset the tracker when it appears
        }
    }

    // Current Exercise View
    private var currentExerciseView: some View {
        let currentExercise = day.exercises[currentExerciseIndex]
        print(day)
        return VStack {
            Text(currentExercise.exerciseName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("Set \(currentSet) of \(currentExercise.sets)")
                .font(.title2)
                .padding(.bottom)

            Text("Reps: \(currentExercise.reps) | Tempo: \(currentExercise.tempo)")
                .foregroundColor(.gray)

            TextField("Enter weight (kg)", text: $weightInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()

            Picker("Effort", selection: $effort) {
                Text("Failed").tag("Failed")
                Text("Max Effort").tag("Max Effort")
                Text("Hard").tag("Hard")
                Text("Medium").tag("Medium")
                Text("Easy").tag("Easy")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Spacer()

            if isResting {
                Text("\(restTimeRemaining) seconds remaining")
                    .font(.title)
                    .padding()
            }

            Button(isResting ? "Skip Rest" : "Next Set") {
                if isResting {
                    endRest()
                } else {
                    saveProgress(exercise: currentExercise)
                    nextSetOrExercise(exercise: currentExercise)
                }
            }
            .font(.title2)
            .padding()
            .background(isResting ? Color.red : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }

    // Workout Complete View
    private var workoutCompleteView: some View {
        VStack {
            Text("Workout Complete!")
                .font(.largeTitle)
                .padding()

            Text("Program: \(day.title)")
                .font(.title2)
                .padding()

            Text("Completed on: \(Date(), formatter: dateFormatter)")
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer()

            Button(action: {
                // Save the workout to history and reset state
                workoutHistory.addWorkout(programName: day.title)
                isWorkoutComplete = false // Notify parent view to close the tracker
                resetTracker() // Reset the tracker state
            }) {
                Text("Done")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }

    private func nextSetOrExercise(exercise: WorkoutExercise) {
        if currentSet < exercise.sets {
            currentSet += 1
            startRest(exercise: exercise)
        } else if currentExerciseIndex < day.exercises.count - 1 {
            currentExerciseIndex += 1
            currentSet = 1
            startRest(exercise: day.exercises[currentExerciseIndex])
        }
    }

    private func startRest(exercise: WorkoutExercise) {
        isResting = true
        restTimeRemaining = exercise.restTime

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.restTimeRemaining > 0 {
                self.restTimeRemaining -= 1
            } else {
                timer.invalidate()
                endRest()
            }
        }
    }

    private func endRest() {
        isResting = false
        restTimeRemaining = 0
    }

    private func saveProgress(exercise: WorkoutExercise) {
        let progressKey = "\(day.day)-\(exercise.exerciseName)-Set\(currentSet)"
        let progressData: [String: Any] = [
            "weight": weightInput,
            "effort": effort
        ]

        UserDefaults.standard.set(progressData, forKey: progressKey)
    }

    private func resetTracker() {
        currentExerciseIndex = 0
        currentSet = 1
        restTimeRemaining = 0
        isResting = false
        weightInput = ""
        effort = "Medium"
    }
}
