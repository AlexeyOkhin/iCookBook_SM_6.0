//
//  AppDelegate.swift
//  iCookBook
//
//  Created by Djinsolobzik on 25.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        startApplicationProcess()

        return true
    }

    func startApplicationProcess() {
       // runLaunchScreen()
        runMainFlow()
    }

    func runMainFlow() {
        self.window?.rootViewController = TabBarConfigurator().configure()
    }

    func runLaunchScreen() {
        let launchScreenViewController = UIStoryboard(name: "LaunchScreen", bundle: .main).instantiateInitialViewController()
        window?.rootViewController = launchScreenViewController
    }

}

