//
//  TaskEntity.swift
//  To-Do-List
//
//  Created by Mahmoud on 18/07/2025.
//

import Foundation

enum TaskStatus: String, Codable {
    case todo, done
}

struct TaskEntity: Codable {
    let id: UUID
    var title: String
    var status: TaskStatus
}
