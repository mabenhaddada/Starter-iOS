//
//  RepoListFlowController.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 08/12/2022.
//

import UIKit

// MARK: - Delegate

protocol RepoListFlowDelegate: FlowController {
    func repoListFlowController(_ flow: RepoListFlowController, didFinishWith error: Error, retry: (() -> Void)?)
}

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
        let vc = RepoListViewController.create(vm: .current())
        vc.delegate = self
        return vc
    }
    
    private func makeRepoDetailViewController(repo: RepoList.Repo) -> RepoDetailViewController {
        let vc = RepoDetailViewController.create(vm: .current(fullName: repo.fullName, description: repo.description))
        vc.delegate = self
        return vc
    }
}

// MARK: - RepoListDelegate

extension RepoListFlowController: RepoListDelegate {
    func repoListViewController(_ vc: RepoListViewController, didFinishWith error: Error, retry: (() -> Void)?) {
        self.flowDelegate?.repoListFlowController(self, didFinishWith: error, retry: retry)
    }
    
    func repoListViewController(_ vc: RepoListViewController, didSelect item: RepoList.Repo) {
        self.pushViewController(makeRepoDetailViewController(repo: item), animated: true)
    }
}

// MARK: - RepoDetailDelegate

extension RepoListFlowController: RepoDetailDelegate {
    func repoDetailViewController(_ vc: RepoDetailViewController, didFinishWith error: Error) {
        self.flowDelegate?.repoListFlowController(self, didFinishWith: error, retry: nil)
    }
}
