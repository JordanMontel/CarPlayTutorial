//
//  DataManager.swift
//  CarPlayTutorial
//
//  Created by Jordan Montel on 15/07/2021.
//

import Foundation

class DataManager {
    
    // MARK: - Properties
    static let shared = DataManager()
    var favoriteRadios = [Radio]()

    // MARK: - Functions
    func getRadios(completionHandler: ([Radio]?) -> Void) {
        var radios = [Radio]()
        do {
            let data = try Data(contentsOf: Bundle.main.url(forResource: "radios", withExtension: "json")!)
            radios = try JSONDecoder().decode([Radio].self, from: data)
            return completionHandler(radios)
        } catch {
            print("getRadios() error", error)
            return completionHandler(nil)
        }
    }
    
    func updateFavoriteRadios(radio: Radio) {
        if favoriteRadios.contains(where: {$0.uid == radio.uid}) {
            favoriteRadios.removeAll(where: {$0.uid == radio.uid})
        } else {
            favoriteRadios.append(radio)
        }
    }
}
