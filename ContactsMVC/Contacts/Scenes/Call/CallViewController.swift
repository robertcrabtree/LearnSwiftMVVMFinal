//
//  CallViewController.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/6/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - CallViewController

class CallViewController: UIViewController {

    // MARK: Properties

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var contactUUID: String!
    
    // MARK: Actions

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        let contact = realm.object(ofType: Contact.self, forPrimaryKey: contactUUID)!
        nameLabel.text = contact.firstName + " " + contact.lastName
        if contact.gender == .male {
            avatarImageView.image = .maleLarge
        } else {
            avatarImageView.image = .femaleLarge
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fadeOut()
    }
    
    // MARK: Private

    private func fadeIn() {
        UIView.animate(withDuration: 1.0, animations: { [weak self] in
            self?.avatarImageView.alpha = 1.0
        }) { [weak self] _ in
            self?.fadeOut()
        }
    }
    
    private func fadeOut() {
        UIView.animate(withDuration: 1.0, animations: { [weak self] in
            self?.avatarImageView.alpha = 0.0
        }) { [weak self] _ in
            self?.fadeIn()
        }
    }
}
