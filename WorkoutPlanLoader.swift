//
//  WorkoutPlanLoader.swift
//  worktes
//
//  Created by Fatih Aysel on 24.01.2025.
//

import Foundation



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
