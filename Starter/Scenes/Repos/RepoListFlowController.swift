//
//  RepoListFlowController.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 08/12/2022.
//

import UIKit

// MARK: - Delegate

protocol RepoListFlowDelegate: FlowController {}

// MARK: - ViewController

class RepoListFlowController: UINavigationController, FlowController, FlowedViewController {
    
    weak var flowDelegate: RepoListFlowDelegate?
    
    var flowController: FlowController? { flowDelegate }
    
    static func create() -> RepoListFlowController {
        let flow = RepoListFlowController()
        return flow
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pushViewController(makeRepoListViewController(), animated: false)
    }
    
    private func makeRepoListViewController() -> RepoListViewController {
        let vc = RepoListViewController.create()
        vc.delegate = self
        return vc
    }
}

// MARK: - RepoListDelegate

extension RepoListFlowController: RepoListDelegate {}
