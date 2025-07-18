//
//  DoneVC.swift
//  To-Do-List
//
//  Created by Mahmoud on 17/07/2025.
//

import UIKit
 
class DoneVC: UIViewController {

    @IBOutlet weak var doneTable: UITableView!

    private var viewModel: TaskListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = TaskListViewModel(status: .done, repository: UserDefaultsTaskRepository())

        doneTable.delegate = self
        doneTable.dataSource = self
        doneTable.register(UITableViewCell.self, forCellReuseIdentifier: "DoneCell")

        viewModel.reload()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reload()
        doneTable.reloadData()
    }
}

extension DoneVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredTasks().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = viewModel.filteredTasks()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoneCell", for: indexPath)
        cell.textLabel?.text = "✔︎ \(task.title)"
        cell.textLabel?.textColor = .gray
        return cell
    }
    
}
