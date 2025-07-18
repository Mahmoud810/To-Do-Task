//
//  TaskListViewModel.swift
//  To-Do-List
//
//  Created by Mahmoud on 18/07/2025.
//

import Foundation

class TaskListViewModel {
    private let repository: TaskRepository
    private(set) var tasks: [TaskEntity] = []

    var currentStatus: TaskStatus

    init(status: TaskStatus, repository: TaskRepository) {
        currentStatus = status
        self.repository = repository
        tasks = repository.getTasks()
    }

    func filteredTasks() -> [TaskEntity] {
        tasks.filter { $0.status == currentStatus }
    }

    func addTask(_ title: String) {
        let newTask = TaskEntity(id: UUID(), title: title, status: currentStatus)
        tasks.append(newTask)
        repository.saveTasks(tasks)
    }

    func moveTask(_ task: TaskEntity, to newStatus: TaskStatus) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].status = newStatus
            repository.saveTasks(tasks)
        }
    }

    func deleteTask(_ task: TaskEntity) {
        tasks.removeAll { $0.id == task.id }
        repository.saveTasks(tasks)
    }

    func reload() {
        tasks = repository.getTasks()
    }
}
