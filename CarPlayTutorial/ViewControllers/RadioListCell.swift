//
//  RadioListCell.swift
//  CarPlayTutorial
//
//  Created by Jordan Montel on 14/07/2021.
//

import Foundation
import UIKit

class RadioListCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var radioImageView: UIImageView!
    
    // MARK: - UITableViewCell
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        radioImageView.image = nil
    }
    
    // MARK: - Custom Functions
    func configureWith(radio: Radio) {
        titleLabel.text = radio.title
        subtitleLabel.text = radio.subtitle
        radioImageView.image = UIImage(named: radio.imageUrl)
    }
}
