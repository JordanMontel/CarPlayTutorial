//
//  RadioListViewController.swift
//  CarPlayTutorial
//
//  Created by Jordan Montel on 14/07/2021.
//

import UIKit

class RadioListViewController: UIViewController {
    
    // MARK: - Properties
    var radios = [Radio]()
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View Management
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RadioListCell", bundle: Bundle.main), forCellReuseIdentifier: "RadioListCell")
        
        if UserDefaults.standard.array(forKey: "FavoriteRadios") == nil {
            let favoriteRadios : [String] = []
            UserDefaults.standard.setValue(favoriteRadios, forKey: "FavoriteRadios")
            UserDefaults.standard.synchronize()
        }
        
        do {
            let data = try Data(contentsOf: Bundle.main.url(forResource: "radios", withExtension: "json")!)
            radios = try JSONDecoder().decode([Radio].self, from: data)
            tableView.reloadData()
        } catch { print(error) }
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
    
}
