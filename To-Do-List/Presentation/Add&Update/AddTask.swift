//
//  AddTasl.swift
//  To-Do-List
//
//  Created by Mahmoud on 18/07/2025.
//

import UIKit

class AddTask: UIViewController {
    var onAdd: ((String) -> Void)?
    var onEditStatus: ((TaskEntity) -> Void)?

    var currentStatus: TaskStatus = .todo
    var editingTask: TaskEntity?
    private let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter task title"
        tf.borderStyle = .roundedRect
        return tf
    }()

    private let actionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Add Task", for: .normal)
        btn.backgroundColor = .systemGreen
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 10
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        if let task = editingTask {
            textField.text = task.title
            textField.isEnabled = false
            textField.textColor = .gray
            actionButton.setTitle("Mark as Done", for: .normal)
            actionButton.backgroundColor = .systemBlue
        }

        actionButton.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
    }
    
    func setupUI() {
        view.backgroundColor = .white

        view.addSubview(textField)
        view.addSubview(actionButton)

        textField.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            textField.widthAnchor.constraint(equalToConstant: 250),

            actionButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 160),
        ])
    }

    @objc private func handleAction() {
        if let task = editingTask {
            onEditStatus?(task)
        } else {
            guard let title = textField.text, !title.isEmpty else { return }
            onAdd?(title)
        }

        dismiss(animated: true)
    }
}
