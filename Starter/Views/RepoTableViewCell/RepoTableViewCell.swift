//
//  RepoTableViewCell.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 09/12/2022.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    var fullName: String? {
        didSet { fullNameLabel.text = L10n.RepoListViewController.RepoTableViewCell.fullName(fullName.orEmpty) }
    }

    var forks: Int? {
        didSet { forksLabel.text = L10n.RepoListViewController.RepoTableViewCell.forks(forks ?? .zero) }
    }

    var openIssues: Int? {
        didSet { openIssuesLabel.text = L10n.RepoListViewController.RepoTableViewCell.openIssues(openIssues ?? .zero) }
    }

    var watchers: Int? {
        didSet { watchersLabel.text = L10n.RepoListViewController.RepoTableViewCell.watchers(watchers ?? .zero) }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectedBackgroundView = UIView()
        
        accessoryView = UIImageView(image: UIImage(systemName: "chevron.right")) // swiftlint:disable:this swiftgen_assets
    }
    
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var openIssuesLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
}

#if canImport(Reusable)
import Reusable
extension RepoTableViewCell: NibReusable {}
#endif
