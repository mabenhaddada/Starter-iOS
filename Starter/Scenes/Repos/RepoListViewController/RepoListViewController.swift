//
//  RepoListViewController.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 08/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Delegate

protocol RepoListDelegate: FlowController {
    func repoListViewController(_ vc: RepoListViewController, didFinishWith error: Error, retry: (() -> Void)?)
    func repoListViewController(_ vc: RepoListViewController, didSelect item: RepoList.Repo)
}

// MARK: - ViewController

class RepoListViewController: UIViewController, FlowedViewController {

    typealias ViewModel = RepoList
    typealias Repo = ViewModel.Repo
    
    weak var delegate: RepoListDelegate?
    var flowController: FlowController? { delegate }
    
    static func create(vm: ViewModel) -> RepoListViewController {
        let vc = Scenes.RepoList.initialScene.instantiate()
        vc.viewModel = vm
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = L10n.RepoListViewController.title
        
        tableView.separatorStyle = .none
        tableView.register(cellType: PlaceholderTableViewCell.self)
        tableView.register(cellType: RepoTableViewCell.self)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetch), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        setup()
        fetch()
    }
    
    fileprivate enum Item: Hashable {
        case placeholder
        case repo(Repo)
    }
    
    private var viewModel: ViewModel!
    private let disposeBag = DisposeBag()
    
    private var repos = PublishRelay<[Item]>()
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var dataSource: UITableViewDiffableDataSource<Int, Item>!
    
    private func setup() {
        dataSource = .init(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .repo(let repo):
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: RepoTableViewCell.self)
                cell.fullName = repo.fullName
                cell.forks = repo.forks
                cell.openIssues = repo.openIssues
                cell.watchers = repo.watchers
                
                return cell
            case .placeholder:
                return tableView.dequeueReusableCell(for: indexPath, cellType: PlaceholderTableViewCell.self)
            }
        })
        
        tableView.dataSource = dataSource
        
        var animate = false
        
        repos
            .subscribe(onNext: { [weak dataSource] items in
                guard let dataSource = dataSource else { return  }
                var snapshot = dataSource.snapshot()
                snapshot.deleteAllItems()
                snapshot.appendSections([.zero])
                
                if items.isEmpty {
                    snapshot.appendItems([.placeholder])
                } else {
                    snapshot.appendItems(items)
                }
                dataSource.apply(snapshot, animatingDifferences: animate)
                animate = true
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.delegate?.repoListViewController(self, didFinishWith: error, retry: self.fetch)
            })
            .disposed(by: disposeBag)
        
        tableView
            .rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self,
                      let itemIdentifier = self.dataSource.itemIdentifier(for: indexPath),
                      case let .repo(item) = itemIdentifier  else { return }
                
                self.delegate?.repoListViewController(self, didSelect: item)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                
                self.delegate?.repoListViewController(self, didFinishWith: error, retry: nil)
            })
            .disposed(by: disposeBag)
    }
    
    @OnlyLatestDisposable private var fetchDisposable: Disposable?
    @objc private func fetch() {
        fetchDisposable = viewModel.repos()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onSuccess: { [weak self] repos in
                guard let self = self else { return }
                self.endRefreshing()
                self.repos.accept(repos.map({ .repo($0) }))
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                self.endRefreshing()
                
                self.delegate?.repoListViewController(self, didFinishWith: error, retry: self.fetch)
            })
    }
    
    private func endRefreshing() {
        tableView.refreshControl?.endRefreshing()
    }
}
