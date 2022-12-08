//
//  RepoListViewController.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 08/12/2022.
//

import UIKit

// MARK: - Delegate

protocol RepoListDelegate: FlowController {}

// MARK: - ViewController

class RepoListViewController: UIViewController, FlowedViewController {

    weak var delegate: RepoListDelegate?
    
    var flowController: FlowController? { delegate }
    
    static func create() -> RepoListViewController {
        let vc = Scenes.RepoList.initialScene.instantiate()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
