//
//  AppFlowController.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 08/12/2022.
//

import UIKit

class AppFlowController: UITabBarController, FlowController {
    
    static func create() -> AppFlowController {
        AppFlowController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            setupRepoListFlowController()
        ]
        
        tabBar.isHidden = true
    }
    
    private func setupRepoListFlowController() -> RepoListFlowController {
        let repoListFlow = RepoListFlowController.create()
        repoListFlow.flowDelegate = self
        return repoListFlow
    }
}

// MARK: - RepoListFlowDelegate

extension AppFlowController: RepoListFlowDelegate {}
