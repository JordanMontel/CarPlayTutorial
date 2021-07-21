//
//  RadioListViewController.swift
//  CarPlayTutorial
//
//  Created by Jordan Montel on 14/07/2021.
//

import UIKit
import MediaPlayer
import AVKit

class RadioListViewController: UIViewController {
    
    // MARK: - Properties
    var radios = [Radio]()
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View Management
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nib cell
        tableView.register(UINib(nibName: "RadioListCell", bundle: Bundle.main), forCellReuseIdentifier: "RadioListCell")
        
        // Notifications
        NotificationCenter.default.addObserver(forName: .updateFavoriteRadiosNotification, object: nil, queue: nil) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.getRadios()
        }
        
        // First loading
        getRadios()
    }
    
    // MARK: - Custom Methods
    func getRadios() {
        DataManager.shared.getRadios(completionHandler: { currentRadios in
            self.radios = currentRadios ?? []
            tableView.reloadData()
        })
    }

}

// MARK: - UITableViewDataSource
extension RadioListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return radios.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RadioListCell = tableView.dequeueReusableCell(withIdentifier: "RadioListCell", for: indexPath) as! RadioListCell
        cell.configureWith(radio: radios[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RadioListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("radio", radios[indexPath.row])
    }
}
