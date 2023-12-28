//
//  ViperViewController.swift
//  iOS-ViperArchitecture
//
//  Created by Celleus on 2023/12/27.
//

import UIKit

protocol ViperViewInput {
    // MARK: Callback from presenter
    func fromPresenter(_ todos: [Todo])
}

// MARK: - ViperViewController

@MainActor
final class ViperViewController: UIViewController {
    
    // MARK: Architecture properties
    
    var presenter: ViperPresenterInput!
    
    // MARK: View Life-Cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "add",
            style: .plain,
            target: self,
            action: #selector(add)
        )
        
        presenter.viewDidLoad()
    }
    
    // MARK: Other properties
    
    @IBOutlet weak var tableView: UITableView!
    private var items = [Todo]()
    
    // MARK: Other methods
    
    @objc
    private func add() {
        showTextFieldAlertViewController()
    }
    
    func showTextFieldAlertViewController() {
        let alert: UIAlertController = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(configurationHandler: nil)
        alert.textFields?.first?.placeholder = "Todo"
        let saveTitleAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_: UIAlertAction!) -> Void in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else {
                return
            }
            self.createTodo(text)
            self.presenter.fromView()
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cencel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(saveTitleAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func createTodo(_ title: String) {
        var todo = Todo()
        todo.title = title
        todo.create()
    }
}

// MARK: - ViperViewInput

extension ViperViewController: ViperViewInput {
    func fromPresenter(_ todos: [Todo]) {
        items = todos
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension ViperViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
}
