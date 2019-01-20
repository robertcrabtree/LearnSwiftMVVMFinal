//
//  ContactsViewController.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/4/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - ContactsViewController

class ContactsViewController: UITableViewController {

    // MARK: Properties

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sortByLastSwitch: UISwitch!
    
    var callButtonPressed: ((String) -> Void)?
    var addButtonPressed: (() -> Void)?
    var contactSelected: ((String) -> Void)?
    
    var viewModel: ContactsViewModel! {
        didSet {
            viewModel.didMakeUpdates = { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    var callCoordinator: CallCoordinator?
    var contactCoordinator: ContactCoordinator?

    // MARK: Actions

    @IBAction func addButtonPressed(_ sender: UIButton) {
        addButtonPressed?()
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        viewModel.sortByLast = sender.isOn
    }
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortByLastSwitch.isOn = viewModel.sortByLast

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let headerView = tableView.tableHeaderView else { return }
        
        let height = headerView.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize).height
        var headerFrame = headerView.frame
        if height != headerFrame.size.height {
            headerFrame.size.height = height
            headerView.frame = headerFrame
            tableView.tableHeaderView = headerView
        }
    }
}

// MARK: - UITableViewDataSource

extension ContactsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numContacts
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
                return UITableViewCell()
        }
        
        cell.configure(with: viewModel.cellViewModel(at: indexPath))
        cell.onPhoneButtonPressed = { [weak self] in
            guard let self = self else { return }
            self.callButtonPressed?(self.viewModel.contactUUID(at: indexPath))
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ContactsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        contactSelected?(viewModel.contactUUID(at: indexPath))
    }
}
