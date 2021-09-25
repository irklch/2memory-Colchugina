//
//  SceneDelegate.swift
//  Colchugina_2memoryTest
//
//  Created by Ирина Кольчугина on 22.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window = UIWindow(frame: UIScreen.main.bounds)

        let vc = SearchViewController()
        let navigationVc = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationVc
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window?.windowScene = windowScene
    }

}

