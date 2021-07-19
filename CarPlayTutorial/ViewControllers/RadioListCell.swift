//
//  RadioListCell.swift
//  CarPlayTutorial
//
//  Created by Jordan Montel on 14/07/2021.
//

import Foundation
import UIKit

class RadioListCell: UITableViewCell {
    
    // MARK: - Properties
    var currentRadio: Radio? = nil

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var radioImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!

    // MARK: - UITableViewCell
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        radioImageView.image = nil
    }
    
    // MARK: - Custom Functions
    func configureWith(radio: Radio) {
        currentRadio = radio
        
        titleLabel.text = radio.title
        subtitleLabel.text = radio.subtitle
        radioImageView.image = UIImage(named: radio.imageUrl)
        
        let favoriteImage = DataManager.shared.favoriteRadios.contains(where: {$0.uid == radio.uid}) ? UIImage(named: "favorite") : UIImage(named: "favorite_border")
        favoriteButton.setImage(favoriteImage, for: .normal)
        favoriteButton.isSelected = DataManager.shared.favoriteRadios.contains(where: {$0.uid == radio.uid})
    }
    
    // MARK: - IBAction
    @IBAction func favorite(button: UIButton) {
        
        guard let radio = currentRadio else { return }
        if button.isSelected == true {
            button.isSelected = false
            button.setImage(UIImage(named: "favorite_border"), for: .normal)
        } else {
            button.isSelected = true
            button.setImage(UIImage(named: "favorite"), for: .normal)
        }
        DataManager.shared.updateFavoriteRadios(radio: radio)
        
        NotificationCenter.default.post(name: .updateFavoriteRadiosNotification, object: nil)
    }
    
    
    
    
//    // MARK: - Custom Functions
//    func configureWith(radio: Radio) {
//        currentRadio = radio
//
//        titleLabel.text = radio.title
//        subtitleLabel.text = radio.subtitle
//        radioImageView.image = UIImage(named: radio.imageUrl)
//
//        if let favoriteRadiosUserDefaults = UserDefaults.standard.array(forKey: "FavoriteRadios") as? [String] {
//            let favoriteImage = favoriteRadiosUserDefaults.contains(radio.uid) ? UIImage(named: "favorite") : UIImage(named: "favorite_border")
//            favoriteButton.setImage(favoriteImage, for: .normal)
//            favoriteButton.isSelected = favoriteRadiosUserDefaults.contains(radio.uid)
//        }
//    }
//
//    // MARK: - IBAction
//    @IBAction func favorite(button: UIButton) {
//
//        guard let radio = currentRadio, let favoriteRadiosUserDefaults = UserDefaults.standard.array(forKey: "FavoriteRadios") as? [String] else { return }
//        var favoriteRadios : [String] = favoriteRadiosUserDefaults
//
//        if button.isSelected == true {
//            button.isSelected = false
//            button.setImage(UIImage(named: "favorite_border"), for: .normal)
//
//            favoriteRadios.removeAll(where: { $0 == radio.uid })
//        } else {
//            button.isSelected = true
//            button.setImage(UIImage(named: "favorite"), for: .normal)
//
//            favoriteRadios.append(radio.uid)
//        }
//
//        UserDefaults.standard.setValue(favoriteRadios, forKey: "FavoriteRadios")
//        UserDefaults.standard.synchronize()
//    }
}
