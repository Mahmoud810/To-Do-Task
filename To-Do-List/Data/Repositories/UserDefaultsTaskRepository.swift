//
//  UserDefaultsTaskRepository.swift
//  To-Do-List
//
//  Created by Mahmoud on 18/07/2025.
//

import Foundation

protocol TaskRepository {
    func getTasks() -> [TaskEntity]
    func saveTasks(_ tasks: [TaskEntity])
}


class UserDefaultsTaskRepository: TaskRepository {
    private let key = "tasks_key"

    func getTasks() -> [TaskEntity] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        let tasks = try? JSONDecoder().decode([TaskEntity].self, from: data)
        return tasks ?? []
    }

    func saveTasks(_ tasks: [TaskEntity]) {
        let data = try? JSONEncoder().encode(tasks)
        UserDefaults.standard.set(data, forKey: key)
    }
}
