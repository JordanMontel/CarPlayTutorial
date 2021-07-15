//
//  CarPlaySceneDelegate.swift
//  CarPlayTutorial
//
//  Created by Jordan Montel on 14/07/2021.
//

import CarPlay

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {

    // MARK: - Properties
    var interfaceController: CPInterfaceController?
    var radios = [Radio]()

    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {

        self.interfaceController = interfaceController
        
        do {
            let data = try Data(contentsOf: Bundle.main.url(forResource: "radios", withExtension: "json")!)
            radios = try JSONDecoder().decode([Radio].self, from: data)
            
            // Create a list
            var items = [CPListItem]()
            for radio in radios {
                let item = CPListItem(text: radio.title, detailText: radio.subtitle)
                item.accessoryType = .disclosureIndicator
                item.setImage(UIImage(named: radio.imageSquareUrl))
                items.append(item)
            }
            let section = CPListSection(items: items)
            let radioListTemplate = CPListTemplate(title: "Radios", sections: [section])
            radioListTemplate.tabImage = .add
            
            // Create a favorite list
            let item = CPListItem(text: "Favorite 1", detailText: "Detail 1")
            item.accessoryType = .disclosureIndicator
            let section2 = CPListSection(items: [item])
            let favoriteListTemplate = CPListTemplate(title: "Favorites", sections: [section2])

            // Create a tab bar
            let tabBar = CPTabBarTemplate.init(templates: [radioListTemplate, favoriteListTemplate])
            self.interfaceController?.setRootTemplate(tabBar, animated: true, completion: {_, _ in })
            
        } catch { print(error) }
    }

    // CarPlay disconnected
    private func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnect interfaceController: CPInterfaceController) {
        self.interfaceController = nil
    }

}
