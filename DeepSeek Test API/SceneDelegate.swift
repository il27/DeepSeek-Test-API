//
//  SceneDelegate.swift
//  DeepSeek Test API
//
//  Created by Ильяс on 25.07.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Проверяем, что у нас есть объект UIWindowScene
        guard let windowScene = scene as? UIWindowScene else { return }
        
        // Создаем окно с привязкой к сцене
        let window = UIWindow(windowScene: windowScene)
        
        // Инициализируем главный контроллер
        let viewController = ViewController()
        
        // Устанавливаем его как корневой
        window.rootViewController = viewController
        
        // Сохраняем окно и показываем его
        self.window = window
        window.makeKeyAndVisible()
    }


}

