import SwiftUI



struct ContentView: View {
    
    var body: some View {
        TabView {
            VideoListView()
                .tabItem {
                    Label("Videos", systemImage: "list.dash")
                }

            WorkoutPlanView()
                .tabItem {
                    Label("Program", systemImage: "calendar")
                }

            StartWorkoutView()
                .tabItem {
                    Label("Start", systemImage: "play.circle")
                }
            HistoryView()
                   .tabItem {
                       Label("History", systemImage: "clock")
                   }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
