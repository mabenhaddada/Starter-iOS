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
    
    private func presentError(error: Error, retry: (() -> Void)? = nil) {
        let alertController = UIAlertController(
            title: nil,
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        alertController.addAction(.init(title: L10n.Button.cancel, style: .cancel))
        
        if let retry = retry {
            alertController.addAction(.init(title: L10n.Button.retry, style: .default, handler: { _ in
                retry()
            }))
        } else {
            alertController.addAction(.init(title: L10n.Button.ok, style: .default))
        }
        
        present(alertController, animated: true)
    }
}

// MARK: - RepoListFlowDelegate

extension AppFlowController: RepoListFlowDelegate {
    func repoListFlowController(_ flow: RepoListFlowController, didFinishWith error: Error, retry: (() -> Void)?) {
        presentError(error: error, retry: retry)
    }
}
