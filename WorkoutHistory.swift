import Foundation

class WorkoutHistory: ObservableObject {
    @Published var history: [CompletedWorkout] = [] {
        didSet {
            saveHistory()
        }
    }

    private let historyKey = "WorkoutHistory"

    init() {
        loadHistory()
    }

    func addWorkout(programName: String) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let date = formatter.string(from: Date())

        let completedWorkout = CompletedWorkout(date: date, programName: programName)
        history.append(completedWorkout) // Adds to the history list
        print("Workout added to history: \(completedWorkout)")
    }

    private func saveHistory() {
        do {
            let data = try JSONEncoder().encode(history)
            UserDefaults.standard.set(data, forKey: historyKey)
        } catch {
            print("Failed to save workout history: \(error.localizedDescription)")
        }
    }

    private func loadHistory() {
        if let data = UserDefaults.standard.data(forKey: historyKey) {
            do {
                history = try JSONDecoder().decode([CompletedWorkout].self, from: data)
            } catch {
                print("Failed to load workout history: \(error.localizedDescription)")
            }
        } else {
            history = [] // Initialize with an empty history
        }
    }
}
