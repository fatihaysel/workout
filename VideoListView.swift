import SwiftUI

struct VideoListView: View {
    let exercises: [Exercise] = loadExercises() // Load exercises from JSON
    @State private var searchQuery: String = "" // Search query
    @State private var filteredExercises: [Exercise] = [] // Filtered list

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search exercises...", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: searchQuery) { _ in
                        filterExercises()
                    }

                // List of Exercises
                List(filteredExercises) { exercise in
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
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Videos")
            .onAppear {
                filteredExercises = exercises // Initialize with all exercises
            }
        }
    }

    
    // Function to filter exercises based on the search query
    private func filterExercises() {
        if searchQuery.isEmpty {
            filteredExercises = exercises
        } else {
            filteredExercises = exercises.filter {
                $0.exerciseName.localizedCaseInsensitiveContains(searchQuery) ||
                $0.targetMuscleGroup.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
}
