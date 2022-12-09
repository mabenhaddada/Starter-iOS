//
//  AppDelegate.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 05/12/2022.
//

import UIKit
import os.log

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupServices()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Setup Services
    
    private func setupServices() {
        // FileSystem
        setupFileSystem()
        
        // Persisitence
        let persistence = setupPersistence()
        Current.persistence = { persistence }
        
        // API
        let apiService = setupAPI()
        Current.apiService = { apiService }
    }
    
    private func setupFileSystem() {
        do {
            try AppPaths.createDirectoriesIfNeeded()
        } catch {
            preconditionFailure("Could not setup mandatory folders.")
        }
    }
    
    private func setupPersistence() -> Persistence {
        os_log(
            .debug,
            log: log,
            "⚙️ DB: %{public}@",
            String(describing: URL(fileURLWithPath: AppPaths.dbWritablePath))
        )
        
        do {
            let perssitence = try Persistence(at: AppPaths.dbWritablePath)
            return perssitence
        } catch {
            preconditionFailure(String(describing: error))
        }
    }
    
    private func setupAPI() -> APIServiceProtocol {
        APIService()
    }
}

fileprivate let log = OSLog(category: "SETUP")
