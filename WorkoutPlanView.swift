import SwiftUI

struct WorkoutPlanView: View {
    let workoutPlan: [WorkoutDay] = loadWorkoutPlan()
    @State private var expandedSections: Set<UUID> = [] // Tracks which sections are expanded
    @State private var selectedWorkoutDay: WorkoutDay? = nil
    @State private var navigateToWorkoutTracker: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(workoutPlan) { day in
                    workoutDaySection(for: day)
                }
            }
            .navigationTitle("Workout Plan")
            .background(
                NavigationLink(
                    destination: workoutTrackerView(),
                    isActive: $navigateToWorkoutTracker,
                    label: { EmptyView() }
                )
            )
        }
    }

    private func workoutDaySection(for day: WorkoutDay) -> some View {
        DisclosureGroup(
            isExpanded: Binding(
                get: { expandedSections.contains(day.id) },
                set: { isExpanded in
                    if isExpanded {
                        expandedSections.insert(day.id)
                    } else {
                        expandedSections.remove(day.id)
                    }
                }
            ),
            content: {
                ForEach(day.exercises) { exercise in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(exercise.exerciseName)
                            .font(.headline)
                        Text("Sets: \(exercise.sets) | Reps: \(exercise.reps) | Tempo: \(exercise.tempo)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
                Button(action: {
                    selectedWorkoutDay = day
                    navigateToWorkoutTracker = true
                }) {
                    Text("Start")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 8)
                }
            },
            label: {
                Text(day.day + ": " + day.title)
                    .font(.headline)
            }
        )
        .padding(.vertical, 4)
    }

    private func workoutTrackerView() -> some View {
        if let selectedDay = selectedWorkoutDay {
            return AnyView(WorkoutTrackerView(
                isWorkoutComplete: .constant(false), // Match argument order
                day: selectedDay
            ))
        } else {
            return AnyView(EmptyView())
        }
    }
}
