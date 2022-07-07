//
//  View.swift
//  ViperClass
//
//  Created by Fellipe Ricciardi Chiarello on 7/4/22.
//

import Foundation
import UIKit

//Could have a ViewController
//Protocol to reference the objects to populate this view
//Reference to the presenter

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with users:[User])
    func update(with errpr: String)
}

class UserViewController: UIViewController, AnyView {
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    var presenter: AnyPresenter?
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with users:[User]) {
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.errorLabel.isHidden = true
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.users = []
            self.setupErrorLabel(error: error)
        }
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupErrorLabel(error: String) {
        view.addSubview(errorLabel)
        errorLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        errorLabel.center = view.center
        errorLabel.text = error
        errorLabel.isHidden = false
    }
}
