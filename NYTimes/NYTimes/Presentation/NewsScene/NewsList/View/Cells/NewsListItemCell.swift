//
//  NewsListItemCell.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import UIKit

class NewsListItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: NewsListItemCell.self)
    
    static let height = CGFloat(150)
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAuther: UILabel!
    @IBOutlet var imgArticle: UIImageView!
    @IBOutlet var btnDate: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func bind(_ viewModel: NewsListItemViewModel) {
        self.lblName.text = viewModel.title
        self.lblAuther.text = viewModel.author
        self.btnDate.setTitle(" \(viewModel.published_date ?? "")", for: .normal)
        self.accessoryType = .disclosureIndicator
        self.imgArticle.setImage(with:
                viewModel.image
        )
    }

}
