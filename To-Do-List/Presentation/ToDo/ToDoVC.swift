//
//  ToDoVC.swift
//  To-Do-List
//
//  Created by Mahmoud on 17/07/2025.
//

import UIKit
import UIKit

class ToDoVC: UIViewController {

    @IBOutlet weak var toDoTable: UITableView!
    @IBOutlet weak var addBtn: UIButton!

    private var viewModel: TaskListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Inject ViewModel
        viewModel = TaskListViewModel(status: .todo, repository: UserDefaultsTaskRepository())

        toDoTable.delegate = self
        toDoTable.dataSource = self

        toDoTable.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
        
        addBtn.layer.cornerRadius = 30
        addBtn.clipsToBounds = true
        addBtn.setTitleColor(.white, for: .normal)
        addBtn.backgroundColor = .systemBlue
        addBtn.tintColor = .white

        // Load tasks
        viewModel.reload()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reload()
        toDoTable.reloadData()
    }

    @IBAction func addBtnTapped(_ sender: UIButton) {
        let vc = AddTask()
        vc.currentStatus = .todo
        vc.onAdd = { [weak self] title in
            self?.viewModel.addTask(title)
            self?.toDoTable.reloadData()
        }
        present(vc, animated: true)
    }
}

extension ToDoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredTasks().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = viewModel.filteredTasks()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        cell.textLabel?.text = task.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = viewModel.filteredTasks()[indexPath.row]
        
        let editVC = AddTask()
        editVC.editingTask = task
        editVC.onEditStatus = { [weak self] taskToEdit in
            self?.viewModel.moveTask(taskToEdit, to: .done)
            self?.toDoTable.reloadData()
        }

        present(editVC, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = viewModel.filteredTasks()[indexPath.row]
            viewModel.deleteTask(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}
