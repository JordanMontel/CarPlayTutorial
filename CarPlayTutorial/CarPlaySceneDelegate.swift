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
    let radioListTemplate: CPListTemplate = CPListTemplate(title: "Radios", sections: [])
    let favoriteRadiosListTemplate: CPListTemplate = CPListTemplate(title: "Favorites", sections: [])

    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {

        self.interfaceController = interfaceController
        self.interfaceController?.delegate = self
        
        DataManager.shared.getRadios(completionHandler: { currentRadios in
            self.radios = currentRadios ?? []
            
            // Create a list
            var radioItems = [CPListItem]()
            for radio in radios {
                let item = CPListItem(text: radio.title, detailText: radio.subtitle)
                item.accessoryType = .disclosureIndicator
                item.setImage(UIImage(named: radio.imageSquareUrl))
                radioItems.append(item)
            }
            let radioListSection = CPListSection(items: radioItems)
            radioListTemplate.updateSections([radioListSection])
            radioListTemplate.tabImage = UIImage(named: "radio")
            
            // Create a favorite list
            var favoriteRadioItems = [CPListItem]()
            for radio in DataManager.shared.favoriteRadios {
                let item = CPListItem(text: radio.title, detailText: radio.subtitle)
                item.accessoryType = .disclosureIndicator
                item.setImage(UIImage(named: radio.imageSquareUrl))
                favoriteRadioItems.append(item)
            }
            let favoriteRadiosSection = CPListSection(items: favoriteRadioItems)
            favoriteRadiosListTemplate.updateSections([favoriteRadiosSection])
            favoriteRadiosListTemplate.tabImage = UIImage(named: "half_favorite")

            // Create a tab bar
            let tabBar = CPTabBarTemplate.init(templates: [radioListTemplate, favoriteRadiosListTemplate])
            tabBar.delegate = self
            self.interfaceController?.setRootTemplate(tabBar, animated: true, completion: {_, _ in })
        })
    }

    // CarPlay disconnected
    private func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnect interfaceController: CPInterfaceController) {
        self.interfaceController = nil
    }

}

// MARK: - CPTabBarTemplateDelegate
extension CarPlaySceneDelegate: CPTabBarTemplateDelegate {
    func tabBarTemplate(_ tabBarTemplate: CPTabBarTemplate, didSelect selectedTemplate: CPTemplate) {
        print("here")
    }
}

// MARK: - CPInterfaceControllerDelegate
extension CarPlaySceneDelegate: CPInterfaceControllerDelegate {

    func templateWillAppear(_ aTemplate: CPTemplate, animated: Bool) {
        print("templateWillAppear", aTemplate)
        
        if aTemplate == favoriteRadiosListTemplate {
            var favoriteRadioItems = [CPListItem]()
            for radio in DataManager.shared.favoriteRadios {
                let item = CPListItem(text: radio.title, detailText: radio.subtitle)
                item.accessoryType = .disclosureIndicator
                item.setImage(UIImage(named: radio.imageSquareUrl))
                favoriteRadioItems.append(item)
            }
            let favoriteRadiosSection = CPListSection(items: favoriteRadioItems)
            favoriteRadiosListTemplate.updateSections([favoriteRadiosSection])
        }
        
    }

    func templateDidAppear(_ aTemplate: CPTemplate, animated: Bool) {
        print("templateDidAppear", aTemplate)
    }

    func templateWillDisappear(_ aTemplate: CPTemplate, animated: Bool) {
        print("templateWillDisappear", aTemplate)
    }

    func templateDidDisappear(_ aTemplate: CPTemplate, animated: Bool) {
        print("templateDidDisappear", aTemplate)
    }
}
