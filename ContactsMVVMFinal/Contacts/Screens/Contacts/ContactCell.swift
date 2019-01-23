//
//  ContactCell.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/5/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var phoneButton: UIButton!
    
    var onPhoneButtonPressed: (() -> Void)?

    @IBAction func phoneButtonPressed(_ sender: UIButton) {
        onPhoneButtonPressed?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with viewModel: ContactCellViewModel) {
        nameLabel.text = viewModel.name
        avatarImageView.image = viewModel.gender == .male ? .male : .female
        phoneButton.isHidden = viewModel.isPhoneNumberEmpty
    }
}
