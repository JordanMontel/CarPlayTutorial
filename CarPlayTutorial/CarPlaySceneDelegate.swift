//
//  CarPlaySceneDelegate.swift
//  CarPlayTutorial
//
//  Created by Jordan Montel on 14/07/2021.
//

import CarPlay

class CarPlaySceneDelegate: UIResponder  {

    // MARK: - Properties
    var interfaceController: CPInterfaceController?
    var radios = [Radio]()
    let radioListTemplate: CPListTemplate = CPListTemplate(title: "Radios", sections: [])
    let favoriteRadiosListTemplate: CPListTemplate = CPListTemplate(title: "Favorites", sections: [])

    // MARK: - Custom Methods
    func updateRadiosList() -> CPListSection {
        var radioItems = [CPListItem]()
        for radio in radios {
            let item = CPListItem(text: radio.title, detailText: radio.subtitle)
            item.accessoryType = .disclosureIndicator
            item.setImage(UIImage(named: radio.imageSquareUrl))
            radioItems.append(item)
        }
        return CPListSection(items: radioItems)
    }
    
    func updateFavoriteRadiosList() -> CPListSection {
        var favoriteRadioItems = [CPListItem]()
        for radio in DataManager.shared.favoriteRadios {
            let item = CPListItem(text: radio.title, detailText: radio.subtitle)
            item.accessoryType = .disclosureIndicator
            item.setImage(UIImage(named: radio.imageSquareUrl))
            item.handler = { item, completion in
                DataManager.shared.updateFavoriteRadios(radio: radio)
                NotificationCenter.default.post(name: .updateFavoriteRadiosNotification, object: nil)
                completion()
            }
            favoriteRadioItems.append(item)
        }
        return CPListSection(items: favoriteRadioItems)
    }
    
}

// MARK: - CPTemplateApplicationSceneDelegate
extension CarPlaySceneDelegate: CPTemplateApplicationSceneDelegate {
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {

        self.interfaceController = interfaceController
        self.interfaceController?.delegate = self
        
        // Notifications
        NotificationCenter.default.addObserver(forName: .updateFavoriteRadiosNotification, object: nil, queue: nil) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.favoriteRadiosListTemplate.updateSections([strongSelf.updateFavoriteRadiosList()])
        }
        
        // First download
        DataManager.shared.getRadios(completionHandler: { currentRadios in
            self.radios = currentRadios ?? []
            
            // Create a radio list
            radioListTemplate.updateSections([updateRadiosList()])
            radioListTemplate.tabImage = UIImage(named: "radio")
            
            // Create a favorite radios list
            favoriteRadiosListTemplate.updateSections([updateFavoriteRadiosList()])
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

    }
}

// MARK: - CPInterfaceControllerDelegate
extension CarPlaySceneDelegate: CPInterfaceControllerDelegate {

    func templateWillAppear(_ aTemplate: CPTemplate, animated: Bool) {
        print("templateWillAppear", aTemplate)
        
        if aTemplate == favoriteRadiosListTemplate {
            favoriteRadiosListTemplate.updateSections([updateFavoriteRadiosList()])
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
