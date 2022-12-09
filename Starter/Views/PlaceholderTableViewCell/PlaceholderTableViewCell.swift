//
//  PlaceholderTableViewCell.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 09/12/2022.
//

import UIKit

class PlaceholderTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        placeholerLabel.text = L10n.RepoListViewController.PlaceholderTableViewCell.label
    }
    
    @IBOutlet private weak var placeholerLabel: UILabel!
}

#if canImport(Reusable)
import Reusable
extension PlaceholderTableViewCell: NibReusable {}
#endif
