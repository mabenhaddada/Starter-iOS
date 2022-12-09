//
//  RepoDetailViewController.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 09/12/2022.
//

import UIKit
import RxSwift

// MARK: - Delegate

protocol RepoDetailDelegate: FlowController {
    func repoDetailViewController(_ vc: RepoDetailViewController, didFinishWith error: Error)
}

class RepoDetailViewController: UIViewController, FlowedViewController {

    typealias ViewModel = RepoDetail
    
    weak var delegate: RepoDetailDelegate?
    var flowController: FlowController? { delegate }
    
    static func create(vm: ViewModel) -> RepoDetailViewController {
        let vc = Scenes.RepoDetail.initialScene.instantiate()
        vc.viewModel = vm
        return vc
    }
    
    private var viewModel: ViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameLabel.numberOfLines = .zero
        descriptionLabel.numberOfLines = .zero
        
        setup()
    }
    
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    private func setup() {
        viewModel.info()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] info in
                guard let self = self else { return }
                
                self.fullNameLabel.text = L10n.RepoDetailViewController.fullName(info.fullName)
                self.descriptionLabel.text = L10n.RepoDetailViewController.description(info.description.orEmpty)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                
                self.delegate?.repoDetailViewController(self, didFinishWith: error)
            })
            .disposed(by: disposeBag)
    }
}
